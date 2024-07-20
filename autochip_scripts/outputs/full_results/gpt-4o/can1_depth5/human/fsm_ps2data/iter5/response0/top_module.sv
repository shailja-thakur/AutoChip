module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define states
	typedef enum reg [1:0] {
		IDLE            = 2'b00,
		BYTE1_RECEIVED  = 2'b01,
		BYTE2_RECEIVED  = 2'b10,
		BYTE3_RECEIVED  = 2'b11
	} state_t;
	
	state_t current_state, next_state;

	// 24-bit message register 
	reg [23:0] message;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			out_bytes <= 24'b0;
			done <= 1'b0;
			message <= 24'b0;
		end else begin
			current_state <= next_state;
			if (current_state == BYTE2_RECEIVED && next_state == BYTE3_RECEIVED) begin
				out_bytes <= {message[15:0], in};
				done <= 1'b1;
			end else begin
				done <= 1'b0;
			end
			if (next_state == BYTE1_RECEIVED) begin
				message[23:16] <= in;
			end else if (next_state == BYTE2_RECEIVED) begin
				message[15:8] <= in;
			end else if (next_state == BYTE3_RECEIVED) begin
				message[7:0] <= in;
			end
		end
	end

    // Next state logic
	always @(*) begin
		next_state = current_state;
		
		case (current_state)
			IDLE: begin
				if (in[3] == 1'b1) begin
					next_state = BYTE1_RECEIVED;
				end
			end

			BYTE1_RECEIVED: begin
				next_state = BYTE2_RECEIVED;
			end

			BYTE2_RECEIVED: begin
				next_state = BYTE3_RECEIVED;
			end

			BYTE3_RECEIVED: begin
				next_state = IDLE;
			end
		endcase
	end

endmodule
