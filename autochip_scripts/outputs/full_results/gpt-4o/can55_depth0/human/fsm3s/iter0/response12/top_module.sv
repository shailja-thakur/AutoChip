module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state, next_state;
	
	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
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
	
	// State flip-flops with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic (combinational)
	always @(*) begin
		case (state)
			A, B, C: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end
	
endmodule
