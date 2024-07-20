module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// Define signals
	reg [2:0] state;
	reg [7:0] data;
	reg [2:0] count;
	reg stop_bit_detected;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			stop_bit_detected <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START_BIT;
						count <= 0;
						data <= 0;
						stop_bit_detected <= 0;
					end
				end

				START_BIT: begin
					state <= DATA_BITS;
					count <= count + 1;
				end

				DATA_BITS: begin
					if (count < 7) begin
						state <= DATA_BITS;
						count <= count + 1;
						data <= {data[6:0], in};
					end else begin
						state <= STOP_BIT;
						count <= count + 1;
						data <= {data[6:0], in};
					end
				end

				STOP_BIT: begin
					if (count < 9) begin
						state <= STOP_BIT;
						count <= count + 1;
						if (count == 8 && in == 1'b1) begin
							stop_bit_detected <= 1;
						end
					end else begin
						state <= IDLE;
						done <= stop_bit_detected;
					end
				end

				default: state <= IDLE;
			endcase
		end
	end

	assign done = stop_bit_detected;
endmodule
