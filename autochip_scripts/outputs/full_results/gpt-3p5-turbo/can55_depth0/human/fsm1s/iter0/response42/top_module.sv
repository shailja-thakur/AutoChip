module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter B = 0;
	parameter A = 1;

	reg [1:0] state;
	reg out_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
			out_reg <= 1;
		end else begin
			case(state)
				B: begin
					if (in == 1'b0) begin
						state <= A;
						out_reg <= 1'b1;
					end else begin
						state <= B;
						out_reg <= 1'b1;
					end
				end
				
				A: begin
					if (in == 1'b0) begin
						state <= B;
						out_reg <= 1'b0;
					end else begin
						state <= A;
						out_reg <= 1'b0;
					end
				end
				
				default: begin
					state <= B;
					out_reg <= 1'b1;
				end
			endcase
		end
	end
	
	assign out = out_reg;
	
endmodule
