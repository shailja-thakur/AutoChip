module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	reg [7:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1)
						state <= BYTE2;
				end
				BYTE2: begin
					state <= BYTE3;
				end
				BYTE3: begin
					state <= DONE;
				end
				DONE: begin
					if (in[2] == 0)
						state <= BYTE1;
					else
						state <= BYTE2;
				end
			endcase
		end
	end

	assign done = (state == DONE);

endmodule
