module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					byte1 <= in;
					state <= 1;
				end
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
				out_bytes[23:16] <= byte1;
				out_bytes[15:8] <= byte2;
				out_bytes[7:0] <= byte3;
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 3);

endmodule
