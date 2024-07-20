module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State Encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		RECEIVE_1 = 2'b01,
		RECEIVE_2 = 2'b10,
		RECEIVE_3 = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] message;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			out_bytes <= 24'b0;
			done <= 0;
		end else begin
			state <= next_state;
			if (next_state == RECEIVE_3) begin
				done <= 1;
				out_bytes <= message;
			end else begin
				done <= 0;
			end
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			IDLE: if (in[3]) next_state = RECEIVE_1;
			RECEIVE_1: next_state = RECEIVE_2;
			RECEIVE_2: next_state = RECEIVE_3;
			RECEIVE_3: next_state = IDLE;
		endcase
	end

	always @(posedge clk) begin
		if (state == RECEIVE_1) begin
			message[23:16] <= in;
		end else if (state == RECEIVE_2) begin
			message[15:8] <= in;
		end else if (state == RECEIVE_3) begin
			message[7:0] <= in;
		end
	end
endmodule
