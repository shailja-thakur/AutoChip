module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

reg [4:0] state, next_state;
reg [7:0] data;
reg start_bit_detected, stop_bit_detected;
reg [2:0] bit_counter;

parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		done <= 0;
		data <= 0;
		start_bit_detected <= 0;
		stop_bit_detected <= 0;
		bit_counter <= 0;
	end
	else begin
		state <= next_state;
		done <= (state == STOP) ? 1'b1 : 1'b0;
	end
end

always @(state, in) begin
	case (state)
		IDLE: begin
			if (in == 1'b0)
				next_state = START;
			else
				next_state = IDLE;
		end
		START: begin
			if (in == 1'b0) begin
				start_bit_detected = 1'b1;
				data[0] = 1'b0;
				bit_counter = 1;
				next_state = DATA;
			end
			else
				next_state = START;
		end
		DATA: begin
			if (bit_counter < 8) begin
				data[bit_counter] = in;
				bit_counter = bit_counter + 1;
				next_state = DATA;
			end
			else begin
				next_state = STOP;
			end
		end
		STOP: begin
			if (in == 1'b1) begin
				stop_bit_detected = 1'b1;
				next_state = IDLE;
			end
			else begin
				stop_bit_detected = 1'b0;
				next_state = STOP;
			end
		end
		default: next_state = IDLE;
	endcase
end

endmodule
