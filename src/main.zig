const std = @import("std");
// set available colors here
var clschm = [_]usize{ 0xf2cdcd, 0xcba6f7, 0xb4befe, 0xbac2de, 0x1e1e2e, 0x11111b };

// who cares abt the MSB
inline fn diff(a: usize, b: usize) usize {
    return @intCast(@abs(@as(isize, @intCast(a)) - @as(isize, @intCast(b))));
}

fn find_closest_match(ckl: usize) usize {
    var i: usize = 1;
    while (i < clschm.len) {
        if (ckl < clschm[i]) {
            const d0 = diff(ckl, clschm[i - 1]);
            const d1 = diff(ckl, clschm[i]);
            if (d0 < d1) {
                return clschm[i - 1];
            } else {
                return clschm[i];
            }
        }
        i += 1;
    }
    return clschm[clschm.len - 1];
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();
    const argv = try std.process.argsAlloc(alloc);
    const rgbf = try std.fs.cwd().openFile(argv[1], .{});
    defer rgbf.close();
    const primem = try rgbf.metadata();
    const brick = try alloc.alloc(u8, primem.size());
    defer alloc.free(brick);
    _ = try rgbf.readAll(brick);
    var i: usize = 0;
    std.mem.sort(usize, &clschm, {}, std.sort.asc(usize));
    while (i + 3 < brick.len) {
        const ckl: usize = @intCast(std.mem.readInt(u24, @ptrCast(brick[i..i]), .big));
        const clst = find_closest_match(ckl);
        std.mem.writeInt(u24, @ptrCast(brick[i..i]), @intCast(clst), .big);
        i += 3;
    }
    const nfile = try std.fs.cwd().createFile(argv[2], .{});
    try nfile.writeAll(brick);
    defer nfile.close();
}
