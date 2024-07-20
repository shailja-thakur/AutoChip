module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define state variables
	reg [2:0] state;

	// Define state encoding
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;

	// Define state machine logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= A;
		else
		begin
			case (state)
				A: if (w) state <= A; else state <= B;
				B: if (w) state <= D; else state <= A;
				C: if (w) state <= E; else state <= D;
				D: if (w) state <= C; else if (state == E) state <= F; else state <= D;
				E: if (state == E) state <= D; else if (w) state <= D; else state <= E;
				F: if (w) state <= C; else state <= D;
			endcase
		end
	end

	// Define output logic
	always @(state)
	begin
		case (state)
			E: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
