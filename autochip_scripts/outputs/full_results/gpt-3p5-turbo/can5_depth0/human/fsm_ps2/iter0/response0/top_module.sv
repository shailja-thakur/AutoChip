module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		state <= 2'b00;
		done <= 0;
	end
	else
	begin
		case (state)
			2'b00:
				if (in[3] == 1)
					state <= 2'b01;
				else
					state <= 2'b00;
			2'b01:
				if (in[3] == 1)
					state <= 2'b10;
				else
					state <= 2'b00;
			2'b10:
				if (in[3] == 1)
				begin
					state <= 2'b01;
					done <= 1;
				end
				else
					state <= 2'b00;
		endcase
	end
end

endmodule
