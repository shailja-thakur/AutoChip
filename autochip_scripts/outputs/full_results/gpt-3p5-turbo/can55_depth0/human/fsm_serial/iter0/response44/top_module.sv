module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;
	reg done;

	assign done = (state == 3);

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin // idle state
					if (in == 1)
						state <= 0;
					else
						state <= 1;
					end
				1: begin // start bit state
					state <= 2;
					end
				2: begin // data bit state
					state <= 2;
					end
				3: begin // stop bit state
					if (in == 0)
						state <= 0;
					else
						state <= 3;
					end
				endcase
			end
		end
	end

endmodule
