module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	parameter B = 1'b0;
	parameter A = 1'b1;
	
	reg state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			case(state)
				B: begin
					if (in) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				A: begin
					if (in) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
			endcase
		end
	end
	
	assign out = state;
	
endmodule
