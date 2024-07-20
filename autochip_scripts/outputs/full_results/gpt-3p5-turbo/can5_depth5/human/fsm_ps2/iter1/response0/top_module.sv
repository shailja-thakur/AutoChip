module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	/* Internal signals */
	reg [2:0] state;
	reg [2:0] prev_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1) begin
						prev_state <= 0;
						state <= 1;
					end
				end
				1: begin
					prev_state <= 1;
					state <= 2;
				end
				2: begin
					prev_state <= 2;
					state <= 3;
				end
				3: begin
					prev_state <= 3;
					state <= 0;
				end
			endcase
		end
	end

	assign done = (state == 0 && prev_state == 3);

endmodule
