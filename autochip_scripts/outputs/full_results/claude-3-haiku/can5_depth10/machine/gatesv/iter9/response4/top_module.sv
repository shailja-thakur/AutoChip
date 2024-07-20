module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

assign out_both = in[2:0];
assign out_any = {in[3:1], 1'b0}; // Corrected to make out_any a 4-bit output
assign out_different = in ^ {in[3:1], 1'b0};

endmodule
