module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	reg [1:0] state, next_state;
	reg [1:0] byte_count;
	
	localparam IDLE = 2'b00;
	localparam BYTE1 = 2'b01;
	localparam BYTE2 = 2'b10;
	localparam BYTE3 = 2'b11;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte_count <= 2'b00;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (next_state == IDLE) begin
				byte_count <= 2'b00;
				done <= 1'b0;
			end else if (next_state == BYTE1) begin
				byte_count <= 2'b01;
				done <= 1'b0;
			end else if (next_state == BYTE2) begin
				byte_count <= 2'b10;
				done <= 1'b0;
			end else if (next_state == BYTE3) begin
				byte_count <= byte_count + 1;
				if (byte_count == 2'b10) done <= 1'b1;
			end
		end
	end
	
	always @(*) begin
		case (state)
			IDLE: next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
			BYTE1: next_state = BYTE2;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end
	
endmodule
