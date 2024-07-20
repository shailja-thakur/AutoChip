module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	parameter IDLE = 2'd0;
	parameter START_BIT = 2'd1;
	parameter DATA_BITS = 2'd2;
	parameter STOP_BIT = 2'd3;
	reg [1:0] state, next_state;
	reg done;
	reg [7:0] data;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			state <= next_state;
			done <= 0;
		end
	end

	always @(state or in) begin
		next_state <= state;
		data <= data;

		case (state)
			IDLE: begin
				if (in == 0)
					next_state <= START_BIT;
			end

			START_BIT: begin
				next_state <= DATA_BITS;
			end

			DATA_BITS: begin
				data <= {data[6:0], in};
				next_state <= (data == 8'b11111111) ? STOP_BIT : DATA_BITS;
			end

			STOP_BIT: begin
				if (in == 1) begin
					done <= 1;
					next_state <= IDLE;
				end
			end
		endcase
	end

endmodule
