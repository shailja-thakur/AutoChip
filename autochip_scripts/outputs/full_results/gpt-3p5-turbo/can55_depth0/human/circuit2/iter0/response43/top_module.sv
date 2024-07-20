module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output reg q
);

	always @(*) begin
		if (a == 1'b1) begin
			if (b == 1'b1) begin
				if (c == 1'b1) begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end else begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end
			end else begin
				if (c == 1'b1) begin
					if (d == 1'b1) begin
						q <= 1'b0;
					end else begin
						q <= 1'b1;
					end
				end else begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end
			end
		end else begin
			if (b == 1'b1) begin
				if (c == 1'b1) begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end else begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end
			end else begin
				if (c == 1'b1) begin
					if (d == 1'b1) begin
						q <= 1'b0;
					end else begin
						q <= 1'b1;
					end
				end else begin
					if (d == 1'b1) begin
						q <= 1'b1;
					end else begin
						q <= 1'b0;
					end
				end
			end
		end
	end

endmodule
