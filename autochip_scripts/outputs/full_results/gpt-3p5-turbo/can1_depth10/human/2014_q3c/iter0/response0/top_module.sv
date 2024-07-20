module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	// Declare the temporary variables to store next state and output values
	reg [2:0] next_Y;
	reg next_z;

	// Declare the combinational logic for next state and output
	always @(*) begin
		case ({y, x})
			3'b0000: begin
				next_Y = 3'b000;
				next_z = 1'b0;
			end
			3'b0001: begin
				next_Y = 3'b001;
				next_z = 1'b0;
			end
			3'b0010: begin
				next_Y = 3'b010;
				next_z = 1'b0;
			end
			3'b0011: begin
				next_Y = 3'b001;
				next_z = 1'b1;
			end
			3'b0100: begin
				next_Y = 3'b011;
				next_z = 1'b1;
			end
			default: begin
				next_Y = 3'b000;
				next_z = 1'b0;
			end
		endcase
	end

	// Declare the clocked always block for sequential logic
	always @(posedge clk) begin
		Y0 <= next_Y[0];
		z <= next_z;
	end

endmodule
