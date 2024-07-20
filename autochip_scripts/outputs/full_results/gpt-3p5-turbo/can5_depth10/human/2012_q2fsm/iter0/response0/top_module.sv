module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	parameter E = 2'b100;
	parameter F = 2'b101;

	reg [1:0] state;
	reg z;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= A;
		else
		begin
			case(state)
				A: if (w) state <= B; else state <= A;
				B: if (w) state <= C; else state <= D;
				C: if (w) state <= E; else state <= D;
				D: if (w) state <= F; else state <= A;
				E: if (z) state <= E; else state <= D;
				F: if (z) state <= C; else state <= D;
			endcase
		end
	end

	always @(state)
	begin
		case(state)
			A: z = 1'b0;
			E: z = 1'b1;
			default: z = 1'b0;
		endcase
	end
	
endmodule
