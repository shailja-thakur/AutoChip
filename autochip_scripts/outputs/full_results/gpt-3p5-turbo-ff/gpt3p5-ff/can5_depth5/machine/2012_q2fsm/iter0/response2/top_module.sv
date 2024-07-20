module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
	// State register
	reg [2:0] state;
	
	// Next state logic
	always @(state, w) begin
		case (state)
			A: begin
				if (w == 1) state <= B;
				else if (w == 0) state <= A;
			end
			B: begin
				if (w == 1) state <= C;
				else if (w == 0) state <= D;
			end
			C: begin
				if (w == 1) state <= E;
				else if (w == 0) state <= D;
			end
			D: begin
				if (w == 1) state <= F;
				else if (w == 0) state <= A;
			end
			E: begin
				if (w == 1) state <= E;
				else if (w == 0) state <= D;
			end
			F: begin
				if (w == 1) state <= C;
				else if (w == 0) state <= D;
			end
			default: state <= A;
		endcase
	end
	
	// Output logic
	always @(state) begin
		if (state == E || state == F)
			z = 1;
		else
			z = 0;
	end
	
	// Initial state
	initial begin
		state <= A;
	end
	
endmodule
