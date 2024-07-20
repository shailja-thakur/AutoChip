module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk)
	begin
		if (state == 0)
		begin
			if (a == 1 && b == 0)
			begin
				state <= 1;
				q <= 0;
			end
			else if (a == 0 && b == 0)
			begin
				state <= 0;
				q <= 0;
			end
			else
			begin
				state <= 0;
				q <= 1;
			end
		end
		else if (state == 1)
		begin
			if (a == 0 && b == 1)
			begin
				state <= 0;
				q <= 1;
			end
			else if (a == 0 && b == 0)
			begin
				state <= 1;
				q <= 1;
			end
			else
			begin
				state <= 1;
				q <= 0;
			end
		end
	end

endmodule
