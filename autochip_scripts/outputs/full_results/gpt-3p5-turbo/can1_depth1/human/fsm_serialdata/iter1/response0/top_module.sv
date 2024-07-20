module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// Define states
	typedef enum logic [2:0] {
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_type;

	// Define signals
	reg [2:0] state;
	reg [2:0] next_state;
	reg [7:0] data_bits;
	reg start_bit_detected;
	reg stop_bit_detected;

	// Next state and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START_BIT;
			data_bits <= 8'b0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
			out_byte <= 8'b0;
			done <= 0;
		end else begin
			case (state)
				START_BIT: begin
					start_bit_detected <= in;
					next_state <= start_bit_detected ? DATA_BITS : START_BIT;
				end
				DATA_BITS: begin
					data_bits <= {data_bits[6:0], in};
					next_state <= (data_bits[0] && data_bits[7:1] && ~start_bit_detected) ? STOP_BIT : DATA_BITS;
				end
				STOP_BIT: begin
					stop_bit_detected <= in;
					next_state <= ~stop_bit_detected ? START_BIT : START_BIT;
					done <= ~stop_bit_detected;
				end
			endcase
		end
	end

endmodule
