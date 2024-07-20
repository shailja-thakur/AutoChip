module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state;
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			case (state)
				S: begin
					if (x == 0)
						state <= S;
					else if (x == 1)
						state <= S1;
				end
				S1: begin
					if (x == 0)
						state <= S10;
					else if (x == 1)
						state <= S1;
				end
				S10: begin
					if (x == 0)
						state <= S;
					else if (x == 1)
						state <= S1;
				end
				default: state <= S;
			endcase
		end
	end

	always @(*) begin
		case (state)
			S, S1: z = 0;
			S10: z = x;
			default: z = 0;
		endcase
	end

endmodule
