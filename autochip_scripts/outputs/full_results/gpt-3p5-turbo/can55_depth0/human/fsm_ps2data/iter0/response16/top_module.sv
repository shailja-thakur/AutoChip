module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else begin
		case (state)
			0: begin
				byte1 <= in;
				if (in[3] == 1)
					state <= 1;
			end
			1: begin
				byte2 <= in;
				state <= 2;
			end
			2: begin
				byte3 <= in;
				state <= 3;
			end
			3: begin
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 3);
assign out_bytes = {byte3, byte2, byte1};

endmodule
