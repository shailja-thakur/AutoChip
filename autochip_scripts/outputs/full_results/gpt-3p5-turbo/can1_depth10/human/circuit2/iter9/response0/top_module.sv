module top_module (
    input wire a, 
    input wire b, 
    input wire c, 
    input wire d,
    output wire q
);
	reg q_reg;

	always @(*) begin
		if ((a == 1'b0) && (b == 1'b0) && (c == 1'b0) && (d == 1'b0))
			q_reg = 1'b1;
		else if ((a == 1'b0) && (b == 1'b0) && (c == 1'b0) && (d == 1'b1))
			q_reg = 1'b0;
		else if ((a == 1'b0) && (b == 1'b0) && (c == 1'b1) && (d == 1'b0))
			q_reg = 1'b0;
		else if ((a == 1'b0) && (b == 1'b0) && (c == 1'b1) && (d == 1'b1))
			q_reg = 1'b1;
		else if ((a == 1'b0) && (b == 1'b1) && (c == 1'b0) && (d == 1'b0))
			q_reg = 1'b0;
		else if ((a == 1'b0) && (b == 1'b1) && (c == 1'b0) && (d == 1'b1))
			q_reg = 1'b1;
		else if ((a == 1'b0) && (b == 1'b1) && (c == 1'b1) && (d == 1'b0))
			q_reg = 1'b1;
		else if ((a == 1'b0) && (b == 1'b1) && (c == 1'b1) && (d == 1'b1))
			q_reg = 1'b0;
		else if ((a == 1'b1) && (b == 1'b0) && (c == 1'b0) && (d == 1'b0))
			q_reg = 1'b0;
		else if ((a == 1'b1) && (b == 1'b0) && (c == 1'b0) && (d == 1'b1))
			q_reg = 1'b1;
		else if ((a == 1'b1) && (b == 1'b0) && (c == 1'b1) && (d == 1'b0))
			q_reg = 1'b1;
		else if ((a == 1'b1) && (b == 1'b0) && (c == 1'b1) && (d == 1'b1))
			q_reg = 1'b0;
		else if ((a == 1'b1) && (b == 1'b1) && (c == 1'b0) && (d == 1'b0))
			q_reg = 1'b1;
		else if ((a == 1'b1) && (b == 1'b1) && (c == 1'b0) && (d == 1'b1))
			q_reg = 1'b0;
		else if ((a == 1'b1) && (b == 1'b1) && (c == 1'b1) && (d == 1'b0))
			q_reg = 1'b0;
		else if ((a == 1'b1) && (b == 1'b1) && (c == 1'b1) && (d == 1'b1))
			q_reg = 1'b1;
	end

	assign q = q_reg;
  
endmodule
