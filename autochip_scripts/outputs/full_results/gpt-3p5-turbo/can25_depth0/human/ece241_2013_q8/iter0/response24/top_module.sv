module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [1:0] state;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= 2'b00;
			z <= 1'b0;
		end else begin
			case (state)
				0: begin // state 0
					if (x == 1'b1)
						state <= 1;
					else
						state <= 0;
				end
				1: begin // state 1
					if (x == 1'b0)
						state <= 0;
					else
						state <= 2;
				end
				2: begin // state 2
					if (x == 1'b1)
						state <= 0;
					else
						state <= 2;
				end
			endcase
		end
	end

	always @(state, x) begin
		if (state == 2'b10)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
