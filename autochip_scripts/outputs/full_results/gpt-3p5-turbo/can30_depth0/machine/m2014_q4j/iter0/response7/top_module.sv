module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	
	// Declare the internal wires
	wire [4:0] sum_temp;
	
	// Instantiate the adder module
	adder adder_inst (
		.x(x),
		.y(y),
		.sum(sum_temp)
	);
	
	// Assign the sum_temp to the sum output
	assign sum = sum_temp;
	
endmodule
module adder (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	
	// Declare internal wires and reg variables
	wire [3:0] x_xor_y;
	reg [4:0] carry_out;
	wire [3:0] carry_in;
	
	// Perform the XOR operation on the inputs x and y
	assign x_xo_r_y = x ^ y;
	
	// Assign the carry in and carry out wires
	assign carry_in[0] = 1'b0;
	assign carry_in[1] = carry_out[0];
	assign carry_in[2] = carry_out[1];
	assign carry_in[3] = carry_out[2];
	assign carry_in[4] = carry_out[3];
	
	// Perform the full adder operation
	always @(*) begin
		for (i = 0; i < 4; i = i + 1) begin
			if (i == 0) begin
				carry_out[i] = x_xor_y[i] & carry_in[i];
			end else begin
				carry_out[i] = x_xor_y[i] & (carry_in[i] | carry_out[i-1]);
			end
			sum[i] = x_xor_y[i] ^ carry_in[i] ^ carry_out[i];
		end
		sum[4] = carry_out[3];
	end
	
endmodule
