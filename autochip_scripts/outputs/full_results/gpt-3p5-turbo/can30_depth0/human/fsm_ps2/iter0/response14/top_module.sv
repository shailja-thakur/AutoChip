module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else
		case (state)
			0: begin
				if (in[3] == 1)
					begin
						byte1 <= in;
						state <= 1;
					end
				else
					state <= 0;
				end
			1: begin
				byte2 <= in;
				state <= 2;
				end
			2: begin
				byte3 <= in;
				state <= 0;
				end
		endcase
	end

assign done = (state == 2);

endmodule
