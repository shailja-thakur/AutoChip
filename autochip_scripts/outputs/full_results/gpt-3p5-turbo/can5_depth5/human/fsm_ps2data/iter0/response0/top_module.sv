module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

// State definitions
parameter [1:0] STATE_IDLE = 2'b00;
parameter [1:0] STATE_BYTE1 = 2'b01;
parameter [1:0] STATE_BYTE2 = 2'b10;
parameter [1:0] STATE_BYTE3 = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= STATE_IDLE;
		byte1 <= 8'd0;
		byte2 <= 8'd0;
		byte3 <= 8'd0;
	end else begin
		case (state)
			STATE_IDLE: begin
				if (in[3]) begin
					state <= STATE_BYTE1;
					byte1 <= in;
				end
			end
			STATE_BYTE1: begin
				state <= STATE_BYTE2;
				byte2 <= in;
			end
			STATE_BYTE2: begin
				state <= STATE_BYTE3;
				byte3 <= in;
			end
			STATE_BYTE3: begin
				state <= STATE_IDLE;
				out_bytes <= {byte3, byte2, byte1};
			end
		endcase
	end
end

assign done = (state == STATE_IDLE);

endmodule
