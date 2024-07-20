module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] byte_buffer;

	parameter IDLE   = 2'b00,
	          BYTE1  = 2'b01,
	          BYTE2  = 2'b10,
              BYTE3  = 2'b11;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte_buffer <= 24'd0;
			done <= 0;
		end else begin
			state <= next_state;
			if (done == 1) done <= 0;
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in[3] == 1) begin
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
				next_state = IDLE;
			end
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			byte_buffer <= 24'd0;
		end else begin
			case (next_state)
				BYTE1: byte_buffer[23:16] <= in;
				BYTE2: byte_buffer[15:8] <= in;
				BYTE3: byte_buffer[7:0] <= in;
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'd0;
		end else if (state == BYTE3) begin
			out_bytes <= byte_buffer;
			done <= 1;
		end
	end

endmodule
