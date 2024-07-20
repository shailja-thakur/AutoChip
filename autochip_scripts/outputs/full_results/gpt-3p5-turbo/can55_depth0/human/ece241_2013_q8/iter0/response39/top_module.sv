module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state;
	parameter IDLE = 0;
	parameter S1 = 1;
	parameter S2 = 2;

	always @(posedge clk, negedge aresetn) begin
		if (~aresetn) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					if (x == 1'b1)
						state <= S1;
				end
				S1: begin
					if (x == 1'b0)
						state <= S2;
					else
						state <= IDLE;
				end
				S2: begin
					if (x == 1'b1)
						state <= IDLE;
				end
				default: state <= IDLE;
			endcase
		end
	end

	always @(state, x) begin
		case(state)
			IDLE: z <= 1'b0;
			S1: z <= 1'b0;
			S2: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
