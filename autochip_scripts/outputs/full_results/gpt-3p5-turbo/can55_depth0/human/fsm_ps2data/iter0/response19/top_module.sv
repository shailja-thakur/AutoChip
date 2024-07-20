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

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		out_bytes <= 24'b0;
		done <= 0;
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
				out_bytes <= {byte1, byte2, byte3};
				state <= 3;
			end
			
			3: begin
				done <= 1;
				state <= 0;
			end
		endcase
	end
end

endmodule
