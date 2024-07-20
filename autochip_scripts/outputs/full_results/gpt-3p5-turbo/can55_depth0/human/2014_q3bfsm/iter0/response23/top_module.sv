module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Declare state register
	reg [2:0] y;
	
	// Declare next state variable
	reg [2:0] next_state;
	
	// Declare output
	assign z = (y == 3'b011) ? 1'b1 : 1'b0;
	
	// Sequential Logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			y <= 3'b000;
		else
			y <= next_state;
	end
	
	// Next state logic
	always @(y or x) begin
		case (y)
			3'b000:
				if (x)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			3'b001:
				if (x)
					next_state = 3'b100;
				else
					next_state = 3'b001;
			3'b010:
				if (x)
					next_state = 3'b001;
				else
					next_state = 3'b010;
			3'b011:
				if (x)
					next_state = 3'b010;
				else
					next_state = 3'b001;
			3'b100:
				if (x)
					next_state = 3'b100;
				else
					next_state = 3'b011;
		endcase
	end
	
endmodule
