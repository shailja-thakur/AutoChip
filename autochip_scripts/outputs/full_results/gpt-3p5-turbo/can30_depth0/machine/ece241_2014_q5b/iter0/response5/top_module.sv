module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 1;
	parameter B = 2;
	
	reg [1:0] state;
	
	always @(posedge clk or negedge areset) begin
		if (~areset) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if (x) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				
				B: begin
					state <= B;
				end
			endcase
		end
	end
	
	assign z = (state == A && x) || (state == B && ~x);
	
endmodule
