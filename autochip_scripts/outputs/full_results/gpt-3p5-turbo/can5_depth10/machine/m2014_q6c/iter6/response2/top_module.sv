module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	initial begin
		#10 y = 6'b000001;
		#10 w = 1'b0;
		#10;
		#10 y = 6'b101010;
		#10 w = 1'b1;
		#10;
		#10 y = 6'b011110;
		#10 w = 1'b1;
		#10;
		#10 y = 6'b111111;
		#10 w = 1'b0;
		#10;
		#10 $finish;
	end

	always @ (*)
	begin
		Y2 = y[1] & ~w;
		Y4 = &y[2] & y[3] & y[5] & y[6] & w;
	end

endmodule
