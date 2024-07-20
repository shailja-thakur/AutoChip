module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [3:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= 0;
		done <= 0;
	end else begin
		case(state)
			0: begin
				if(in[3] == 1)
					state <= 1;
				else
					state <= 0;
			end
			1: begin
				if(in[3] == 1)
					state <= 2;
				else
					state <= 0;
			end
			2: begin
				if(in[3] == 1) begin
					done <= 1;
					state <= 0;
				end else
					state <= 0;
			end
			default: state <= 0;
		endcase
	end
end

endmodule
