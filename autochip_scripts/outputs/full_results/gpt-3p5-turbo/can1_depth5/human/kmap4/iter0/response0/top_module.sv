module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	if(a == 0) begin
		if(b == 0) begin
			if(c == 0) begin
				if(d == 0)
					out = 0;
				else
					out = 1;
			end else begin
				if(d == 0)
					out = 1;
				else
					out = 0;
			end
		end else begin
			if(c == 0) begin
				if(d == 0)
					out = 0;
				else
					out = 1;
			end else begin
				if(d == 0)
					out = 1;
				else
					out = 0;
			end
		end
	end else begin
		if(b == 0) begin
			if(c == 0) begin
				if(d == 0)
					out = 0;
				else
					out = 1;
			end else begin
				if(d == 0)
					out = 1;
				else
					out = 0;
			end
		end else begin
			if(c == 0) begin
				if(d == 0)
					out = 0;
				else
					out = 1;
			end else begin
				if(d == 0)
					out = 1;
				else
					out = 0;
			end
		end
	end
end
endmodule
