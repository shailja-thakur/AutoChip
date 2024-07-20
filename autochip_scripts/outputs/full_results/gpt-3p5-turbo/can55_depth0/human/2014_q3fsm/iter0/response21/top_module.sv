module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg state;
reg [2:0] count;

parameter A = 0, B = 1;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
		count <= 0;
		z <= 0;
	end else begin
		case (state)
			A: begin
				if (s == 1) begin
					state <= B;
					count <= 0;
				end
			end
			B: begin
				if (count == 3) begin
					if (count == 2)
						z <= 1;
					else
						z <= 0;
					count <= 0;
					state <= A;
				end else begin
					if (w == 1)
						count <= count + 1;
					else
						count <= count;
				end
			end
		endcase
	end
end

endmodule
