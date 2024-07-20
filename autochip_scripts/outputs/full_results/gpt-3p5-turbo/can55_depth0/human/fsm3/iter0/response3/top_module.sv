module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
			out <= 0;
		end
		else begin
			state <= next_state;
			case(state)
				2'b00: begin
					if (in)
						next_state = 2'b01;
					else
						next_state = 2'b10;
					out <= 0;
				end
				2'b01: begin
					if (in)
						next_state = 2'b11;
					else
						next_state = 2'b01;
					out <= 0;
				end
				2'b10: begin
					if (in)
						next_state = 2'b00;
					else
						next_state = 2'b10;
					out <= 0;
				end
				2'b11: begin
					if (in)
						next_state = 2'b10;
					else
						next_state = 2'b01;
					out <= 1;
				end
				default: begin
					next_state = 2'b00;
					out <= 0;
				end
			endcase
		end
	end
	
endmodule
