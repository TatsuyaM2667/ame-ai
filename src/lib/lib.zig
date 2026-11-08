// ame-shell の src/lib から、この道具が使う部品だけを持ってきたもの(生成。直すときは ame-shell の方を直す)
pub const ai = @import("ai.zig");
pub const mcp = @import("mcp.zig");

test {
    _ = ai;
    _ = mcp;
}
