module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;

	parameter WAIT = 4'b0000;
	parameter FOUND = 4'b0001;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= WAIT;
			start_shifting <= 0;
		end
		else begin
			state <= next_state;
			start_shifting <= (state == FOUND);
		end
	end

	always @(state or data) begin
		next_state <= state;

		case (state)
			WAIT: begin
				if (data) begin
					next_state <= (data == 1'b1) ? FOUND : WAIT;
				end
			end
			FOUND: begin
				next_state <= WAIT;
			end
		endcase
	end

endmodule
