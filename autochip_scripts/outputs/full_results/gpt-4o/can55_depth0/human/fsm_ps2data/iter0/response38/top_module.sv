module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define state encoding
	typedef enum logic [1:0] {
		IDLE = 2'b00,
		BYTE1 = 2'b01,
		BYTE2 = 2'b10,
		BYTE3 = 2'b11
	} state_t;
	
	reg [1:0] current_state, next_state;
	reg [23:0] message_buffer;

	// State transition
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			message_buffer <= 24'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			current_state <= next_state;
			if (done) begin
				out_bytes <= message_buffer;
			end
		end
	end

	// Next state logic
	always_comb begin
		next_state = current_state;
		done = 1'b0;
		case (current_state)
			IDLE: begin
				if (in[3]) begin
					next_state = BYTE1;
				end
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				done = 1'b1;
				next_state = IDLE;
			end
		endcase
	end

	// Data path logic
	always_ff @(posedge clk) begin
		if (reset) begin
			message_buffer <= 24'b0;
		end else if (current_state == BYTE1) begin
			message_buffer[23:16] <= in;
		end else if (current_state == BYTE2) begin
			message_buffer[15:8] <= in;
		end else if (current_state == BYTE3) begin
			message_buffer[7:0] <= in;
		end
	end

endmodule
