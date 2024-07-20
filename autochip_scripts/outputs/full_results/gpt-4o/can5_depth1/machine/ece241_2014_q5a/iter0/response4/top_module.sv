module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;

	reg [1:0] state, next_state;

	// State transition on the positive edge of clk or areset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Determine next state based on current state and input x
	always @(*) begin
		case (state)
			A: begin
				if (x) next_state = C;
				else next_state = A;
			end
			B: begin
				if (x) next_state = B;
				else next_state = C;
			end
			C: begin
				if (x) next_state = B;
				else next_state = C;
			end
			default: next_state = A;
		endcase
	end
	
	// Output z based on the current state
	always @(*) begin
		case (state)
			C: z = 1;
			default: z = 0;
		endcase
	end

endmodule
