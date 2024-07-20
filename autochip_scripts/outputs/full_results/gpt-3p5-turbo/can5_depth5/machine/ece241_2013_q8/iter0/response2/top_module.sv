module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [3:0] state;
	parameter S = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S10 = 4'b0010;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			case (state)
				S: begin
					if (x == 1) begin
						state <= S1;
					end else begin
						state <= S;
					end
				end
				
				S1: begin
					if (x == 0) begin
						state <= S10;
					end else begin
						state <= S1;
					end
				end
				
				S10: begin
					if (x == 1) begin
						state <= S1;
					end else begin
						state <= S;
					end
				end
				
				default: state <= S;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			S, S1: z <= 0;
			S10: z <= x;
			default: z <= 0;
		endcase
	end
endmodule
