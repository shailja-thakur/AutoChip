module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [1:0] state;

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		state <= 0;
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
	end
	else
	begin
		case(state)
			0: begin
				if(in[3] == 1'b1)
					state <= 1;
			end
			1: begin
				state <= 2;
				byte1 <= in;
			end
			2: begin
				state <= 3;
				byte2 <= in;
			end
			3: begin
				state <= 0;
				byte3 <= in;
				done <= 1;
			end
		endcase
  	end
end

endmodule
