module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 0;
	parameter B = 1;
	reg [1:0] state;
	
	always @(posedge clk) begin
		if (areset == 1'b1) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x == 1'b1) begin
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
	
	assign z = (state == A && x == 1'b1) || (state == B && x == 1'b0) ? 1'b1 : 1'b0;
	
endmodule
