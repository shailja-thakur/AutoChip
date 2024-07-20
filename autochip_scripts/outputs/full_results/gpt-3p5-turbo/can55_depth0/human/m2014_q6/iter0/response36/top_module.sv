module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define state variables
	reg [2:0] state;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	// Define next state logic
	always @(posedge clk) begin
		if (reset == 1) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (w == 0)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (w == 0)
						state <= C;
					else
						state <= D;
				end
				C: begin
					if (w == 0)
						state <= E;
					else
						state <= D;
				end
				D: begin
					if (w == 0)
						state <= F;
					else
						state <= A;
				end
				E: begin
					if (w == 0)
						state <= E;
					else
						state <= D;
				end
				F: begin
					if (w == 0)
						state <= C;
					else
						state <= D;
				end
			endcase
		end
	end

	// Define output logic
	always @(state, w) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
		endcase
	end

endmodule
