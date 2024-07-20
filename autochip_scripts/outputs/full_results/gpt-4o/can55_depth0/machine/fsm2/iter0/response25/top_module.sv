module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	
	// State encoding
	typedef enum logic [1:0] {A = 1'b0, B = 1'b1} state_t;
	state_t state, next_state;
	
	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A;
		endcase
	end

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
	
endmodule
