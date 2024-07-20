module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [1:0] state;
parameter WAIT_FOR_START = 2'b00;
parameter RECV_BYTE1 = 2'b01;
parameter RECV_BYTE2 = 2'b10;
parameter RECV_BYTE3 = 2'b11;

always @(posedge clk) begin
	if (reset) begin
		state <= WAIT_FOR_START;
		done <= 0;
	end
	else begin
		case (state)
			WAIT_FOR_START: begin
				if (in[3]) begin
					state <= RECV_BYTE1;
				end
				done <= 0;
			end
			RECV_BYTE1: begin
				state <= RECV_BYTE2;
				done <= 0;
			end
			RECV_BYTE2: begin
				state <= RECV_BYTE3;
				done <= 0;
			end
			RECV_BYTE3: begin
				state <= WAIT_FOR_START;
				done <= 1;
			end
		endcase
	end
end

endmodule
