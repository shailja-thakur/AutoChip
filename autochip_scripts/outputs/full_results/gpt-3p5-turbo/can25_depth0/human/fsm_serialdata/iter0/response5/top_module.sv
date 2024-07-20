module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// Enumerated type for state encoding
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// Internal signals
	reg [2:0] state;
	reg [7:0] byte;
	reg done;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			byte <= 8'b0;
			done <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START_BIT;
						byte <= 8'b0;
						done <= 1'b0;
					end
				end

				START_BIT: begin
					state <= DATA_BITS;
				end

				DATA_BITS: begin
					if (in == 1'b0) begin
						if (byte < 8)
							byte <= {byte[6:0], in};
						else
							state <= STOP_BIT;
					end
				end

				STOP_BIT: begin
					if (in == 1'b1) begin
						state <= IDLE;
						out_byte <= byte;
						done <= 1'b1;
					end
				end
			endcase
		end
	end

endmodule
