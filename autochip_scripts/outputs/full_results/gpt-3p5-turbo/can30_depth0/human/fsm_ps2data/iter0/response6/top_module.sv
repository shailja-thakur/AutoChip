module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] buffer [2:0];
reg [2:0] state;

integer i;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
	end else begin
		case(state)
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
				out_bytes[23:16] <= buffer[0];
				out_bytes[15:8] <= buffer[1];
				out_bytes[7:0] <= buffer[2];
				state <= 4;
			end
			4: begin
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 4);

endmodule
