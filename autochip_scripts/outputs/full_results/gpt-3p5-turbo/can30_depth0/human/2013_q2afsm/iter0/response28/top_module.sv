module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

	parameter A = 3'b001;
	parameter B = 3'b010;
	parameter C = 3'b100;
	parameter D = 3'b000;
	
	reg [2:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if (r[1] && !r[2] && !r[3]) begin
						state <= A;
					end else if (r[1]) begin
						state <= B;
					end else if (!r[1] && r[2]) begin
						state <= C;
					end else begin
						state <= D;
					end
				end
				B: begin
					if (r[1] && !r[2] && !r[3]) begin
						state <= A;
					end else if (r[1] && !r[2]) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				C: begin
					if (r[1] && !r[2] && !r[3]) begin
						state <= A;
					end else if (!r[1] && r[2]) begin
						state <= C;
					end else begin
						state <= A;
					end
				end
				default: state <= A;
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			A: begin
				g <= 3'b001;
			end
			B: begin
				if (r[1]) begin
					g <= 3'b010;
				end else begin
					g <= 3'b001;
				end
			end
			C: begin
				if (r[2]) begin
					g <= 3'b100;
				end else begin
					g <= 3'b001;
				end
			end
			default: g <= 3'b001;
		endcase
	end

endmodule
