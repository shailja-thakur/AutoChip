module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] message;
	reg [1:0] byte_counter;

	localparam IDLE = 2'b00;
	localparam BYTE1 = 2'b01;
	localparam BYTE2 = 2'b10;
	localparam BYTE3 = 2'b11;

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte_counter <= 2'b00;
		end
		else begin
			state <= next_state;
			if (state == BYTE1 || state == BYTE2) begin
				byte_counter <= byte_counter + 1;
			end
			if (state == BYTE3) begin
				byte_counter <= 2'b00;
			end
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state;
		done = 1'b0;
		case (state)
			IDLE: if (in[3] == 1'b1) next_state = BYTE1;
			BYTE1: next_state = BYTE2;
			BYTE2: next_state = BYTE3;
			BYTE3: begin
				next_state = IDLE;
				done = 1'b1;
			end
		endcase
	end

	// Byte assembly
	always @(posedge clk) begin
		if (reset) begin
			message <= 24'h0;
			out_bytes <= 24'h0;
		end
		else begin
			case (state)
				BYTE1: message[23:16] <= in;
				BYTE2: message[15:8] <= in;
				BYTE3: begin
					message[7:0] <= in;
					out_bytes <= {message[23:8], in};
				end
			endcase
		end
	end

endmodule
