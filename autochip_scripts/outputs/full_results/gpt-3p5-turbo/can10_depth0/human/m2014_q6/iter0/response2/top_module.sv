module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (w) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				B: begin 
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
				C: begin 
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				D: begin 
					if (w) begin
						state <= A;
					end else begin
						state <= F;
					end
				end
				E: begin 
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				F: begin 
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
				default: state <= A;
			endcase
		end
	end
	
	always @(state, w) begin
		case (state)
			A: begin
				z <= 0;
			end
			B: begin
				z <= 0;
			end
			C: begin
				z <= 0;
			end
			D: begin
				z <= 0;
			end
			E: begin
				z <= 1;
			end
			F: begin
				z <= 1;
			end
			default: z <= 0;
		endcase
	end

endmodule
