module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] buffer [0:2];

reg [2:0] state;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		done_reg <= 0;
		buffer[0] <= 0;
		buffer[1] <= 0;
		buffer[2] <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					buffer[0] <= in;
					state <= 1;
				end
			end
			1: begin
				buffer[1] <= in;
				state <= 2;
			end
			2: begin
				buffer[2] <= in;
				state <= 3;
			end
			3: begin
				buffer[0] <= in;
				state <= 1;
				done_reg <= 1;
			end
		endcase
	end
end

assign out_bytes = {buffer[2], buffer[1], buffer[0]};
assign done = done_reg;

endmodule
