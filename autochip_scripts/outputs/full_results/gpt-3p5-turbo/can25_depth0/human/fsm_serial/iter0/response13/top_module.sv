module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;
	reg received_start_bit;
	reg [7:0] received_data;
	reg received_stop_bit;

	parameter IDLE = 3'b000;
	parameter RECEIVE_START_BIT = 3'b001;
	parameter RECEIVE_DATA_BITS = 3'b010;
	parameter RECEIVE_STOP_BIT = 3'b011;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			received_start_bit <= 0;
			received_data <= 8'b0;
			received_stop_bit <= 0;
		end else begin
			case (state)
				IDLE:
					if (in == 1'b0) begin
						received_start_bit <= 1;
						state <= RECEIVE_DATA_BITS;
					end
				RECEIVE_START_BIT:
					if (in == 1'b0) begin
						state <= RECEIVE_DATA_BITS;
					end
				RECEIVE_DATA_BITS:
					begin
						received_data <= {received_data[6:0], in};
						if (received_data[7] == 1'b1) begin
							state <= RECEIVE_STOP_BIT;
						end
					end
				RECEIVE_STOP_BIT:
					begin
						if (in == 1'b1) begin
							received_stop_bit <= 1;
							state <= IDLE;
						end
					end
			endcase
		end
	end

	assign done = (state == IDLE) && (received_start_bit) && (received_stop_bit);

endmodule
