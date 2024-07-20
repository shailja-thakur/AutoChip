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
	else
		case (state)
			0: begin
				if (in[3])
					state <= 1;
				else
					state <= 0;
			end
			1: begin
				byte1 <= in;
				state <= 2;
			end
			2: begin
				byte2 <= in;
				state <= 3;
			end
			3: begin
				byte3 <= in;
				state <= 4;
			end
			4: state <= 5;
			default: state <= 0;
		endcase
	end

always @(posedge clk) begin
	if (state == 5) begin
		out_bytes[23:16] <= byte1;
		out_bytes[15:8] <= byte2;
		out_bytes[7:0] <= byte3;
		done <= 1;
	end else begin
		out_bytes <= 0;
		done <= 0;
	end
end

endmodule
