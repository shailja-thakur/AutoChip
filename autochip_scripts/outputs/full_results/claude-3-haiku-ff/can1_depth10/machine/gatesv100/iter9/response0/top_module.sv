module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:0] out_any,
    output reg [99:0] out_different
);

wire [99:0] shifted_in;
assign shifted_in = {in[98:0], in[99]};

always @* begin
    out_both = in & shifted_in;
    out_any = {1'b0, in[99:1]};
    out_different = in ^ shifted_in;
    out_different[0] = in[0] ^ shifted_in[99];
end

endmodule
