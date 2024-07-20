module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [9:0] count;
reg [7:0] byte;
reg start_bit;
reg [7:0] receive_byte;

parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter RECEIVE = 2'b10;
parameter CHECK_STOP = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		count <= 0;
		byte <= 0;
		start_bit <= 0;
		receive_byte <= 0;
	end else begin
		state <= next_state;
		count <= count + 1;
		byte <= {byte[6:0], in};
		start_bit <= byte[7];
		receive_byte <= byte;
	end
end

always @(*) begin
	case (state)
		IDLE: begin
			done = 0;
			out_byte = 8'bzzzzzzzz;
			if (reset) begin
				next_state = IDLE;
				count = 0;
				byte = 0;
				start_bit = 0;
				receive_byte = 0;
			end else if (start_bit == 0) begin
				next_state = START;
				count = 0;
				byte = 0;
				start_bit = 0;
				receive_byte = 0;
			end else begin
				next_state = IDLE;
				count = 0;
				byte = 0;
				receive_byte = 0;
			end
		end
		START: begin
			done = 0;
			out_byte = 8'bzzzzzzzz;
			if (count == 8) begin
				next_state = CHECK_STOP;
				count = 0;
			end else begin
				next_state = RECEIVE;
				count = count + 1;
			end
			byte = {byte[6:0], in};
		end
		RECEIVE: begin
			done = 0;
			out_byte = 8'bzzzzzzzz;
			if (count == 8) begin
				next_state = CHECK_STOP;
				count = 0;
			end else begin
				next_state = RECEIVE;
				count = count + 1;
			end
			byte = {byte[6:0], in};
		end
		CHECK_STOP: begin
			done = (in == 1 && count == 1 && start_bit == 0) ? 1 : 0;
			out_byte = receive_byte;
			if (in == 1 && count == 1 && start_bit == 0) begin
				next_state = IDLE;
				count = 0;
				byte = 0;
				start_bit = 0;
				receive_byte = 0;
			end else begin
				next_state = CHECK_STOP;
				count = count + 1;
			end
		end
	endcase
end

endmodule
