module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state, next_state;
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= 2'b00;
			z <= 1'b0;
		end else begin
			state <= next_state;
			case (state)
				2'b00: begin
					if (x == 1'b0)
						next_state <= 2'b00;
					else if (x == 1'b1)
						next_state <= 2'b01;
				end
				2'b01: begin
					if (x == 1'b0)
						next_state <= 2'b10;
					else if (x == 1'b1)
						next_state <= 2'b01;
				end
				2'b10: begin
					if (x == 1'b0)
						next_state <= 2'b00;
					else if (x == 1'b1)
						next_state <= 2'b01;
				end
				default: next_state <= 2'b00;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b00: z <= 1'b0;
			2'b01: z <= 1'b0;
			2'b10: z <= x;
			default: z <= 1'b0;
		endcase
	end
endmodule
