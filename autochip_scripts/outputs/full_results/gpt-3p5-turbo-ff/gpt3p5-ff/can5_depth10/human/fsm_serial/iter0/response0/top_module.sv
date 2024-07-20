module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state, next_state;
reg done, start_bit, stop_bit;
reg [7:0] data;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter RECEIVE_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		done <= 0;
		start_bit <= 0;
		stop_bit <= 0;
		data <= 0;
	end else begin
		state <= next_state;
		done <= 0;
		start_bit <= start_bit;
		stop_bit <= stop_bit;
		data <= data;
	end
end

always @(state, in) begin
	case(state)
		IDLE: begin
			if (in) begin
				start_bit <= 0;
				next_state <= IDLE;
			end else begin
				start_bit <= 1;
				next_state <= START_BIT;
			end
		end

		START_BIT: begin
			start_bit <= 1;
			next_state <= RECEIVE_BITS;
		end

		RECEIVE_BITS: begin
			data <= {data[6:0], in};
			
			if (state == 7) begin
				stop_bit <= in;
				next_state <= STOP_BIT;
			end else begin
				next_state <= RECEIVE_BITS;
			end
		end

		STOP_BIT: begin
			if (in) begin
				next_state <= IDLE;
				done <= 1;
			end else begin
				next_state <= STOP_BIT;
			end
		end

		default: next_state <= IDLE;
	endcase
end

endmodule
