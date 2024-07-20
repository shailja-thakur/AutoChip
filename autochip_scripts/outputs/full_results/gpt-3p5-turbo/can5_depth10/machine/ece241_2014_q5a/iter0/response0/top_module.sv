module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	reg [1:0] state;

	always @(posedge clk or areset) begin
		if (areset == 1'b1) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x == 1'b1) begin
						state <= C;
					end else begin
						state <= A;
					end
				end

				B: begin
					if (x == 1'b1) begin
						state <= B;
					end else begin
						state <= C;
					end
				end

				C: begin
					if (x == 1'b1) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end

	assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
