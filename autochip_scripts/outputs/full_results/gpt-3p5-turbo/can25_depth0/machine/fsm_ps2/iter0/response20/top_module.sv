module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [1:0] state;

parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= BYTE1;
		done <= 0;
	end
	else begin
		case(state)
			BYTE1: begin
				if(in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			BYTE2: state <= BYTE3;
			BYTE3: state <= DONE;
			DONE: begin
				if(in[2] == 0)
					state <= BYTE1;
				else
					state <= BYTE2;
			end
		endcase
	end
end

assign done = (state == DONE);

endmodule
