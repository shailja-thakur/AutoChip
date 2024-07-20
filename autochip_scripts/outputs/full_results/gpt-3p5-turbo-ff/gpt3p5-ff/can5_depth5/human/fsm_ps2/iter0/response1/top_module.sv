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
parameter [2:0] IDLE = 0, BYTE1 = 1, BYTE2 = 2, BYTE3 = 3;

always @(posedge clk or posedge reset) begin
	if(reset)
		state <= IDLE;
	else begin
		case(state)
			IDLE: begin
				if(in[3] == 1)
					state <= BYTE1;
			end
			BYTE1: begin
				byte1 <= in;
				state <= BYTE2;
			end
			BYTE2: begin
				byte2 <= in;
				state <= BYTE3;
			end
			BYTE3: begin
				byte3 <= in;
				state <= IDLE;
				done <= 1;
			end
		endcase
	end
end

endmodule
