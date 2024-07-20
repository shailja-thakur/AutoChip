module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

	reg cout_reg;
	reg sum_reg;

	always @ (a or b or cin) begin
		cout_reg <= a + b + cin >= 2 ? 1'b1 : 1'b0;
		sum_reg <= a + b + cin;
	end
	
	assign cout = cout_reg;
	assign sum = sum_reg % 2;
	
endmodule
