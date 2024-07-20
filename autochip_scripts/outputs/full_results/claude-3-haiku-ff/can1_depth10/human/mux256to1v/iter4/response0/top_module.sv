module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [31:0] selected_bits;

assign selected_bits = in[((sel + 1) * 32 - 1) : (sel * 32)];
assign out = selected_bits[3:0];

endmodule
