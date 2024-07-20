module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state, next_state;
	
	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			A: if (in)
					next_state = B;
				else
					next_state = A;
			B: if (in)
					next_state = B;
				else
					next_state = C;
			C: if (in)
					next_state = D;
				else
					next_state = A;
			D: if (in)
					next_state = B;
				else
					next_state = C;
			default: next_state = A;
		endcase
	end
	
	// Output logic
	always @(*) begin
		if (state == D)
			out = 1;
		else
			out = 0;
	end
	
endmodule
