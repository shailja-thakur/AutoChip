module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states of the FSM
parameter WAIT_FOR_START = 2'b00;
parameter READ_BYTE1 = 2'b01;
parameter READ_BYTE2 = 2'b10;
parameter READ_BYTE3 = 2'b11;

reg [1:0] state;
reg done;

always @(posedge clk) begin
	if(reset) begin
		state <= WAIT_FOR_START;
		done <= 0;
	end
	else begin
		case(state)
			WAIT_FOR_START: begin
				if(in[3] == 1)
					state <= READ_BYTE1;
			end
			READ_BYTE1: begin
				state <= READ_BYTE2;
			end
			READ_BYTE2: begin
				state <= READ_BYTE3;
			end
			READ_BYTE3: begin
				state <= WAIT_FOR_START;
				done <= 1;
			end
		endcase
	end
end

endmodule
