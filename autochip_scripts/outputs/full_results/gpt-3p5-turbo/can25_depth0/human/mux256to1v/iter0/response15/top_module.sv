module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [7:0] index;
wire [3:0] bits [255:0];

// Generate the index value based on the sel input
always @*
	begin
		if (sel >= 0 && sel < 256)
			index = sel;
		else
			index = 0;
	end

// Assign the 4-bit values to the bits array
genvar i;
generate
for (i = 0; i < 256; i = i+1)
begin: ASSIGN_BITS
	assign bits[i] = in[(4*i+3):4*i];
end
endgenerate

// Connect the selected bits to the output
assign out = bits[index];

endmodule
