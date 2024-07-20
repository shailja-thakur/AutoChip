module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [3:0] state;
reg done;

localparam BYTE1 = 4'b0001;
localparam BYTE2 = 4'b0010;
localparam BYTE3 = 4'b0100;
localparam DONE = 4'b1000;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		done <= 0;
	end else begin
		case(state)
			BYTE1: begin
				if (in[2] == 1'b1)
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
				if (in[2] == 1'b1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
		endcase
	end
end

always @(state) begin
	if (state == DONE)
		done <= 1;
	else
		done <= 0;
	end
end

endmodule
