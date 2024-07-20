module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output reg [7:0] w,
    output reg [7:0] x,
    output reg [7:0] y,
    output reg [7:0] z
);

    always @(*) begin
        w = {a[4:0], b[4:0], c[4:0], d[4:0], e[4:0], f[4:0], 2'b11};
        x = {a[4:0], b[4:0], c[4:0], d[4:0], e[4:0], f[4:0], 2'b11};
        y = {a[4:0], b[4:0], c[4:0], d[4:0], e[4:0], f[4:0], 2'b11};
        z = {a[4:0], b[4:0], c[4:0], d[4:0], e[4:0], f[4:0], 2'b11};
    end

endmodule
