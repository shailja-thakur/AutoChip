module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;
	parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if(w) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				B: begin
					if(w) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				C: begin
					if(w) begin
						state <= E;
					end else begin
						state <= D;
					end
				end
				D: begin
					if(state == E) begin
						state <= F;
					end else if(w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
				E: begin
					if(w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				F: begin
					if(w) begin
						state <= C;
					end else begin
						state <= D;
					end
				end
			endcase
		end
	end

	always @* begin
		case(state)
			E: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
