module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create an array to store the 256 4-bit inputs
	reg [3:0] inputs [255:0];
	
	// Assign the 1024-bit input vector to the array
	// Each 4-bit input is assigned to the corresponding element in the array
	genvar i;
	generate
		for (i = 0; i < 256; i = i + 1) begin : assign_inputs
			assign inputs[i] = in[(i+1)*4 - 1:i*4];
		end
	endgenerate
	
	// Use the select bits to choose the correct 4-bit input
	always @* begin
		case (sel)
			0: out = inputs[0];
			1: out = inputs[1];
			2: out = inputs[2];
			3: out = inputs[3];
			4: out = inputs[4];
			5: out = inputs[5];
			6: out = inputs[6];
			7: out = inputs[7];
			default: out = 4'b0;
		endcase
	end
endmodule
