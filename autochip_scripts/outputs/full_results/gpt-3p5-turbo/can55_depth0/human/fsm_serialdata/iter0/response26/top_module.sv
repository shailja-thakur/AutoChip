module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] shift_register;
reg start_bit_detected;
reg [2:0] bit_counter;

parameter IDLE = 0;
parameter DETECT_START_BIT = 1;
parameter RECEIVE_DATA_BITS = 2;
parameter VERIFY_STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		bit_counter <= 0;
		shift_register <= 0;
		start_bit_detected <= 0;
		out_byte <= 0;
		done <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 0) begin
					state <= DETECT_START_BIT;
					bit_counter <= 0;
					shift_register <= 0;
					start_bit_detected <= 0;
				end
			end
			DETECT_START_BIT: begin
				if (in == 0 && start_bit_detected == 0) begin
					start_bit_detected <= 1;
				end else if (start_bit_detected == 1) begin
					state <= RECEIVE_DATA_BITS;
				end else begin
					state <= IDLE;
				end
			end
			RECEIVE_DATA_BITS: begin
				if (in == 1) begin
					shift_register <= {in, shift_register[7:1]};
					bit_counter <= bit_counter + 1;
				end
				
				if (bit_counter == 7) begin
					state <= VERIFY_STOP_BIT;
				end
			end
			VERIFY_STOP_BIT: begin
				if (in == 1 && bit_counter == 7) begin
					shift_register <= {in, shift_register[7:1]};
					state <= IDLE;
					out_byte <= shift_register;
					done <= 1;
				end else if (in == 0) begin
					state <= RECEIVE_DATA_BITS;
				end else begin
					state <= IDLE;
				end
			end
			default: state <= IDLE;
		endcase
	end
end

endmodule
