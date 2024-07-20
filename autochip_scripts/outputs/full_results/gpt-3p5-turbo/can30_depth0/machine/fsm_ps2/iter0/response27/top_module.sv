module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

reg [1:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
		endcase
	end
end

assign done = (state == DONE);

endmodule
