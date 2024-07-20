module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	if (c==0) begin
		if (d==0) begin
			if (a==0) begin
				if (b==0) begin
					out = 0;
				end
				else begin
					out = 1;
				end
			end
			else begin
				if (b==0) begin
					out = 1;
				end
				else begin
					out = 1;
				end
			end
		end
		else begin
			if (a==0) begin
				out = d;
			end
			else begin
				out = d;
			end
		end
	end
	else begin
		if (a==0) begin
			if (b==0) begin
				out = 0;
			end
			else begin
				out = d;
			end
		end
		else begin
			out = d;
		end
	end
end

endmodule
