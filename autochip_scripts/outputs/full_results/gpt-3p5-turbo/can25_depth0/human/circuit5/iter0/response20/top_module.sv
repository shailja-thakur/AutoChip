module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @* begin
		if (c[0] == 0 && c[1] == 0 && c[2] == 0 && c[3] == 0) begin
			q[0] = b[0];
			q[1] = b[1];
			q[2] = b[2];
			q[3] = b[3];
		end
		else if (c[0] == 0 && c[1] == 0 && c[2] == 0 && c[3] == 1) begin
			q[0] = e[0];
			q[1] = e[1];
			q[2] = e[2];
			q[3] = e[3];
		end
		else if (c[0] == 0 && c[1] == 0 && c[2] == 1 && c[3] == 0) begin
			q[0] = a[0];
			q[1] = a[1];
			q[2] = a[2];
			q[3] = a[3];
		end
		else if (c[0] == 0 && c[1] == 0 && c[2] == 1 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 0 && c[1] == 1 && c[2] == 0 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 0 && c[1] == 1 && c[2] == 0 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 0 && c[1] == 1 && c[2] == 1 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 0 && c[1] == 1 && c[2] == 1 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 0 && c[2] == 0 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 0 && c[2] == 0 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 0 && c[2] == 1 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 0 && c[2] == 1 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 1 && c[2] == 0 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 1 && c[2] == 0 && c[3] == 1) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else if (c[0] == 1 && c[1] == 1 && c[2] == 1 && c[3] == 0) begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
		else begin
			q[0] = d[0];
			q[1] = d[1];
			q[2] = d[2];
			q[3] = d[3];
		end
	end

endmodule
