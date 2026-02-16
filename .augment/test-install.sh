#!/usr/bin/env bash
# Test script to verify Superpowers installation for Augment

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
PASSED=0
FAILED=0

# Test functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Installation paths
AUGMENT_DIR="${HOME}/.augment"
INSTALL_DIR="${AUGMENT_DIR}/superpowers"
SKILLS_DIR="${AUGMENT_DIR}/skills/superpowers"
INSTRUCTIONS_FILE="${AUGMENT_DIR}/superpowers-instructions.md"

echo ""
info "Testing Superpowers installation for Augment..."
echo ""

# Test 1: Check installation directory
if [ -d "$INSTALL_DIR" ]; then
    pass "Installation directory exists: ${INSTALL_DIR}"
else
    fail "Installation directory not found: ${INSTALL_DIR}"
fi

# Test 2: Check skills symlink
if [ -L "$SKILLS_DIR" ]; then
    pass "Skills symlink exists: ${SKILLS_DIR}"
    
    # Verify it points to the right place
    TARGET=$(readlink "$SKILLS_DIR")
    if [ "$TARGET" = "${INSTALL_DIR}/skills" ]; then
        pass "Skills symlink points to correct location"
    else
        fail "Skills symlink points to wrong location: ${TARGET}"
    fi
else
    fail "Skills symlink not found: ${SKILLS_DIR}"
fi

# Test 3: Check instructions file
if [ -f "$INSTRUCTIONS_FILE" ]; then
    pass "Instructions file exists: ${INSTRUCTIONS_FILE}"
    
    # Verify it contains expected content
    if grep -q "You have superpowers" "$INSTRUCTIONS_FILE"; then
        pass "Instructions file contains expected content"
    else
        fail "Instructions file missing expected content"
    fi
else
    fail "Instructions file not found: ${INSTRUCTIONS_FILE}"
fi

# Test 4: Check key skills exist
REQUIRED_SKILLS=(
    "brainstorming"
    "test-driven-development"
    "systematic-debugging"
    "writing-plans"
    "using-superpowers"
)

for skill in "${REQUIRED_SKILLS[@]}"; do
    SKILL_FILE="${SKILLS_DIR}/${skill}/SKILL.md"
    if [ -f "$SKILL_FILE" ]; then
        pass "Skill exists: ${skill}"
    else
        fail "Skill not found: ${skill}"
    fi
done

# Test 5: Check Git repository
if [ -d "${INSTALL_DIR}/.git" ]; then
    pass "Git repository exists (can be updated)"
else
    fail "Git repository not found (updates won't work)"
fi

# Summary
echo ""
echo "================================"
echo "Test Results:"
echo "  Passed: ${GREEN}${PASSED}${NC}"
echo "  Failed: ${RED}${FAILED}${NC}"
echo "================================"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    echo ""
    info "Next steps:"
    echo "  1. Add to your project's .augment/instructions.md:"
    echo "     ${YELLOW}@~/.augment/superpowers-instructions.md${NC}"
    echo ""
    echo "  2. Start a new Augment session and ask:"
    echo "     ${YELLOW}\"Do you have superpowers?\"${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    echo ""
    info "Try reinstalling:"
    echo "  ${YELLOW}~/.augment/superpowers/.augment/install.sh${NC}"
    echo ""
    exit 1
fi

