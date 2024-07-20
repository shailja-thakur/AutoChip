module top_module (
    input [15:0] in,
    output [7:0] out_hi,
    output [7:0] out_lo
);

	assign out_hi = in[15:8];   // Assigning upper [15:8] bytes to out_hi
    assign out_lo = in[7:0];    // Assigning lower [7:0] bytes to out_lo

endmodule
