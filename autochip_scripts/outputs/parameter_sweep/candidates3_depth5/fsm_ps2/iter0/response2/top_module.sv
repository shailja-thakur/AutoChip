module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;

parameter IDLE = 0;
parameter BYTE1 = 1;
parameter BYTE2 = 2;
parameter BYTE3 = 3;

reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in[3] == 1) begin
					state <= BYTE1;
					byte1 <= in;
				end
			end

			BYTE1: begin
				state <= BYTE2;
				byte2 <= in;
			end

			BYTE2: begin
				state <= BYTE3;
				byte3 <= in;
			end

			BYTE3: begin
				state <= IDLE;
				done <= 1;
			end
		endcase
	end
end

endmodule
