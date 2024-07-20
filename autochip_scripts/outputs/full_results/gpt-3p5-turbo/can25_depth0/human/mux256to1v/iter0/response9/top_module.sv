module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Declare internal signals
wire [255:0] inputs[0:255];

// Split the input vector into 4-bit inputs
generate
    for (genvar i = 0; i < 256; i = i + 1) begin: INPUT_SPLIT
        assign inputs[i] = in[i*4 +: 4];
    end
endgenerate

// Select the appropriate input based on sel
assign out = inputs[sel];

endmodule
