module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	typedef enum reg [1:0] {A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11} state_type;
	state_type state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
			default: next_state = A;
		endcase
	end
	
	// State flip-flops with synchronous reset (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic (combinational)
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b0; 
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
