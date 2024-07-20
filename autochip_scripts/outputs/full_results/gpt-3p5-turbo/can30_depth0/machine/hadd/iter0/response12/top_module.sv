module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    wire [31:0] sum_tmp;
	assign sum_tmp = a + b;
	assign sum = sum_tmp[31:0];
	assign cout = sum_tmp[32];
endmodule
