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
		if (areset == 0) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x == 1) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					state <= B;
				end
				default: begin
					state <= A;
				end
			endcase
		end
	end

	assign z = (state == A && x == 1) || (state == B && x == 0);
	
endmodule
