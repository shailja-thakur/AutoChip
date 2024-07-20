module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done;

reg [2:0] state;
parameter [2:0] IDLE = 3'b000;
parameter [2:0] BYTE1_RECEIVED = 3'b001;
parameter [2:0] BYTE2_RECEIVED = 3'b010;
parameter [2:0] BYTE3_RECEIVED = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		done <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			IDLE: if (in[3] == 1) begin
					byte1 <= in;
					state <= BYTE1_RECEIVED;
				end
			BYTE1_RECEIVED: begin
					byte2 <= in;
					state <= BYTE2_RECEIVED;
				end
			BYTE2_RECEIVED: begin
					byte3 <= in;
					state <= BYTE3_RECEIVED;
				end
			BYTE3_RECEIVED: begin
					state <= IDLE;
					done <= 1;
				end
		endcase
	end
end
endmodule
