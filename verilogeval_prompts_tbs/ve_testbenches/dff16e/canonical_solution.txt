	
	always @(posedge clk) begin
		if (!resetn)
			q <= 0;
		else begin
			if (byteena[0])
				q[7:0] <= d[7:0];
			if (byteena[1])
				q[15:8] <= d[15:8];
		end
	end
	
endmodule
