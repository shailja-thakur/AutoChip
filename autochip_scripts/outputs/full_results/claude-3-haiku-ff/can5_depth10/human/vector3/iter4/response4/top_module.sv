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

wire [29:0] concat_input;
assign concat_input = {a, b, c, d, e, f};

always @(*) begin
    w = concat_input[7:0];
    x = concat_input[15:8];
    y = concat_input[23:16];
    z = {concat_input[29:24], 2'b11};
end

endmodule
