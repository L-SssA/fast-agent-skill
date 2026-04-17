#!/usr/bin/env python3
"""
Skill Validator - 验证 Agent Skill 是否符合官方规范
用法: python validate-skill.py [skill_directory]
如果不提供参数，将验证当前目录

注意：此脚本不需要任何外部依赖，使用 Python 标准库即可运行
"""

import os
import sys
import re
from pathlib import Path


class SkillValidator:
    def __init__(self, skill_dir):
        self.skill_dir = Path(skill_dir)
        self.errors = []
        self.warnings = []
        self.checks_passed = []

    def validate(self):
        """执行所有验证检查"""
        print("=" * 60)
        print("  Agent Skill 验证工具")
        print("=" * 60)
        print(f"\n正在验证技能目录: {self.skill_dir}\n")

        # 检查 SKILL.md 是否存在
        skill_file = self.skill_dir / "SKILL.md"
        if not skill_file.exists():
            print("[错误] SKILL.md 文件不存在！")
            return False

        # 读取 SKILL.md 内容
        with open(skill_file, 'r', encoding='utf-8') as f:
            content = f.read()
            lines = content.split('\n')

        # 执行各项检查
        self._check_frontmatter(content, skill_file)
        self._check_naming_convention()
        self._check_description(content)
        self._check_line_count(lines)
        self._check_progressive_disclosure()
        self._check_file_references(content)
        self._check_structure()

        # 输出结果
        self._print_results()

        return len(self.errors) == 0

    def _parse_frontmatter(self, content):
        """解析 YAML frontmatter（简化版，不依赖 yaml 库）"""
        if not content.startswith('---'):
            return None

        # 找到第二个 ---
        end_match = re.search(r'\n---\n', content[3:])
        if not end_match:
            return None

        yaml_content = content[3:3 + end_match.start()]

        # 简单的 YAML 解析（仅处理基本的 key: value 格式）
        result = {}
        for line in yaml_content.split('\n'):
            line = line.strip()
            if ':' in line and not line.startswith('#'):
                key, _, value = line.partition(':')
                key = key.strip()
                value = value.strip().strip('"').strip("'")
                result[key] = value

        return result if result else None

    def _check_frontmatter(self, content, skill_file):
        """检查 frontmatter 必要字段"""
        frontmatter = self._parse_frontmatter(content)

        if not frontmatter:
            self.errors.append("缺少有效的 YAML frontmatter")
            return

        # 检查 name 字段
        if 'name' not in frontmatter:
            self.errors.append("frontmatter 中缺少 'name' 字段")
        else:
            self.checks_passed.append("✓ frontmatter 包含 'name' 字段")

        # 检查 description 字段
        if 'description' not in frontmatter:
            self.errors.append("frontmatter 中缺少 'description' 字段")
        else:
            self.checks_passed.append("✓ frontmatter 包含 'description' 字段")

    def _check_naming_convention(self):
        """检查命名规范"""
        # 解析路径，获取真实的目录名
        resolved_path = self.skill_dir.resolve()
        dir_name = resolved_path.name

        # 如果解析后仍然是根目录或其他特殊情况
        if not dir_name:
            dir_name = self.skill_dir.name

        # 如果还是空，使用当前工作目录的名称
        if not dir_name:
            import os
            dir_name = os.path.basename(os.getcwd())

        # 检查是否只包含小写字母、数字、连字符
        if not re.match(r'^[a-z0-9-]+$', dir_name):
            self.errors.append(
                f"目录名 '{dir_name}' 包含非法字符。"
                f"只允许小写字母、数字和连字符 (a-z, 0-9, -)"
            )
        else:
            self.checks_passed.append(f"✓ 目录名 '{dir_name}' 字符合法")

        # 检查长度
        if len(dir_name) < 1 or len(dir_name) > 64:
            self.errors.append(
                f"目录名 '{dir_name}' 长度为 {len(dir_name)}，"
                f"应在 1-64 字符之间"
            )
        else:
            self.checks_passed.append(f"✓ 目录名长度符合要求 ({len(dir_name)} 字符)")

        # 检查不能以连字符开头或结尾
        if dir_name.startswith('-') or dir_name.endswith('-'):
            self.errors.append(f"目录名 '{dir_name}' 不能以连字符开头或结尾")
        else:
            self.checks_passed.append("✓ 目录名不以连字符开头或结尾")

        # 检查不能有连续连字符
        if '--' in dir_name:
            self.errors.append(f"目录名 '{dir_name}' 包含连续连字符")
        else:
            self.checks_passed.append("✓ 目录名无连续连字符")

        # 检查 name 字段与目录名是否一致
        skill_file = self.skill_dir / "SKILL.md"
        if skill_file.exists():
            with open(skill_file, 'r', encoding='utf-8') as f:
                content = f.read()
            frontmatter = self._parse_frontmatter(content)
            if frontmatter and 'name' in frontmatter:
                if frontmatter['name'] != dir_name:
                    self.errors.append(
                        f"frontmatter 中的 name '{frontmatter['name']}' "
                        f"与目录名 '{dir_name}' 不一致"
                    )
                else:
                    self.checks_passed.append("✓ name 字段与目录名一致")

    def _check_description(self, content):
        """检查描述字段"""
        frontmatter = self._parse_frontmatter(content)
        if not frontmatter or 'description' not in frontmatter:
            return

        description = frontmatter['description']

        # 检查长度
        if len(description) > 1024:
            self.errors.append(
                f"description 长度为 {len(description)} 字符，"
                f"超过 1024 字符限制"
            )
        else:
            self.checks_passed.append(
                f"✓ description 长度符合要求 ({len(description)} 字符)")

        # 检查是否包含"做什么"和"何时使用"
        desc_lower = description.lower()
        has_what = any(keyword in desc_lower for keyword in
                       ['do', 'handle', 'process', 'create', 'generate', '帮助', '处理', '创建'])
        has_when = any(keyword in desc_lower for keyword in
                       ['when', 'use', '需要', '当', '如果'])

        if not has_what:
            self.warnings.append(
                "description 可能未清楚说明'做什么'，"
                "建议添加具体功能描述"
            )
        else:
            self.checks_passed.append("✓ description 包含功能说明")

        if not has_when:
            self.warnings.append(
                "description 可能未清楚说明'何时使用'，"
                "建议添加使用时机说明"
            )
        else:
            self.checks_passed.append("✓ description 包含使用时机")

        # 检查是否使用祈使句
        if description.startswith(('This skill', 'It helps', '这是一个')):
            self.warnings.append(
                "description 建议使用祈使句开头，如 'Use this skill when...' "
                "而非 'This skill does...'"
            )
        else:
            self.checks_passed.append("✓ description 使用祈使句风格")

    def _check_line_count(self, lines):
        """检查 SKILL.md 行数"""
        line_count = len(lines)

        if line_count > 500:
            self.errors.append(
                f"SKILL.md 有 {line_count} 行，超过 500 行限制。"
                f"建议将详细内容移至 references/ 目录"
            )
        else:
            self.checks_passed.append(f"✓ SKILL.md 行数符合要求 ({line_count} 行)")

    def _check_progressive_disclosure(self):
        """检查渐进式披露"""
        references_dir = self.skill_dir / "references"

        if references_dir.exists() and references_dir.is_dir():
            ref_files = list(references_dir.glob('*.md'))
            if ref_files:
                self.checks_passed.append(
                    f"✓ 使用了渐进式披露 (references/ 中有 {len(ref_files)} 个文件)"
                )
            else:
                self.warnings.append(
                    "references/ 目录存在但为空，建议将详细内容放入此目录"
                )
        else:
            # 检查 SKILL.md 是否过长，如果过长则建议创建 references/
            skill_file = self.skill_dir / "SKILL.md"
            if skill_file.exists():
                with open(skill_file, 'r', encoding='utf-8') as f:
                    line_count = len(f.readlines())
                if line_count > 300:
                    self.warnings.append(
                        f"SKILL.md 有 {line_count} 行，建议创建 references/ 目录"
                        f"并将部分内容移出以保持简洁"
                    )

    def _check_file_references(self, content):
        """检查文件引用是否使用相对路径"""
        # 查找 markdown 链接
        links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)

        absolute_paths = []
        for text, url in links:
            # 检查是否是绝对路径或 http 链接
            if url.startswith(('http://', 'https://', '/', '\\')):
                if not url.startswith(('http://', 'https://')):
                    absolute_paths.append(url)

        if absolute_paths:
            self.warnings.append(
                f"发现 {len(absolute_paths)} 个可能的绝对路径引用，"
                f"建议使用相对路径: {', '.join(absolute_paths[:3])}"
            )
        else:
            self.checks_passed.append("✓ 文件引用使用相对路径")

    def _check_structure(self):
        """检查基本目录结构"""
        required_files = ['SKILL.md']
        optional_dirs = ['references', 'assets', 'scripts']

        for req_file in required_files:
            if (self.skill_dir / req_file).exists():
                self.checks_passed.append(f"✓ 存在必要文件: {req_file}")
            else:
                self.errors.append(f"缺少必要文件: {req_file}")

        # 检查是否有 assets 或 scripts 目录（可选）
        for opt_dir in optional_dirs:
            if (self.skill_dir / opt_dir).exists():
                self.checks_passed.append(f"✓ 存在目录: {opt_dir}/")

    def _print_results(self):
        """打印验证结果"""
        print("\n" + "=" * 60)
        print("  验证结果")
        print("=" * 60)

        if self.checks_passed:
            print(f"\n通过检查 ({len(self.checks_passed)}):")
            for check in self.checks_passed:
                print(f"  {check}")

        if self.warnings:
            print(f"\n警告 ({len(self.warnings)}):")
            for warning in self.warnings:
                print(f"  ⚠ {warning}")

        if self.errors:
            print(f"\n错误 ({len(self.errors)}):")
            for error in self.errors:
                print(f"  ✗ {error}")

        print("\n" + "=" * 60)
        if not self.errors:
            if not self.warnings:
                print("✓ 验证通过！技能符合官方规范")
            else:
                print("⚠ 验证通过但有警告，建议修复警告项")
        else:
            print(f"✗ 验证失败！发现 {len(self.errors)} 个错误")
        print("=" * 60)


def main():
    # 确定要验证的目录
    if len(sys.argv) > 1:
        skill_dir = sys.argv[1]
    else:
        skill_dir = "."

    # 检查目录是否存在
    if not os.path.isdir(skill_dir):
        print(f"[错误] 目录 '{skill_dir}' 不存在")
        sys.exit(1)

    # 创建验证器并执行验证
    validator = SkillValidator(skill_dir)
    success = validator.validate()

    # 退出码：0 表示成功，1 表示失败
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
