module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(*) begin
	if(a == 4'b1010) begin
		q = b;
	end
	else if(a > b) begin
		q = e;
	end
	else if (a < b) begin
		q = d;
	end
	else if (c == 4'b0000) begin
		q = b;
	end
	else if (c == 4'b0001) begin
		q = e;
	end
	else if (c == 4'b0010) begin
		q = a;
	end
	else if (c == 4'b0011) begin
		q = d;
	end
	else if (c == 4'b0100) begin
		q = 'f;
	end
	else if (c == 4'b0101) begin
		q = 'f;
	end
	else if (c == 4'b0110) begin
		q = 'f;
	end
	else if (c == 4'b0111) begin
		q = 'f;
	end
	else if (c == 4'b1000) begin
		q = 'f;
	end
	else if (c == 4'b1001) begin
		q = 'f;
	end
	else if (c == 4'b1010) begin
		q = 'f;
	end
	else if (c == 4'b1011) begin
		q = 'f;
	end
	else if (c == 4'b1100) begin
		q = 'f;
	end
	else if (c == 4'b1101) begin
		q = 'f;
	end
	else if (c == 4'b1110) begin
		q = 'f;
	end
	else if (c == 4'b1111) begin
		q = 'f;
	end
	end

endmodule
