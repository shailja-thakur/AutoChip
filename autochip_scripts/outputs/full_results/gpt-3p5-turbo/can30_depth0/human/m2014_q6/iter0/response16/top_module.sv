module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;

	// define states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	initial begin
		state = A; // initial state
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A; // reset to initial state
		else begin
			case (state)
				A: begin
					if (w)
						state <= A;
					else
						state <= B;
				end
				B: begin
					if (w)
						state <= D;
					else
						state <= C;
				end
				C: begin
					if (w)
						state <= D;
					else
						state <= E;
				end
				D: begin
					if (w)
						state <= A;
					else
						state <= F;
				end
				E: begin
					if (w)
						state <= D;
					else
						state <= E;
				end
				F: begin
					if (w)
						state <= D;
					else
						state <= C;
				end
				default: state <= A;
			endcase
		end
	end

	always @(state) begin
		case (state)
			A: z <= 1'b0;
			B: z <= 1'b0;
			C: z <= 1'b0;
			D: z <= 1'b0;
			E: z <= 1'b1;
			F: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end
endmodule
