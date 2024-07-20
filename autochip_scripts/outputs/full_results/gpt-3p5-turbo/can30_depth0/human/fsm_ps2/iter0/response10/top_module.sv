module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					byte1 <= in;
				end
			end
			
			1: begin
				state <= 2;
				byte2 <= in;
			end
			
			2: begin
				state <= 0;
				if (in[3] == 1) begin 
					done <= 1;
				end
			end
		endcase
	end
end

endmodule
