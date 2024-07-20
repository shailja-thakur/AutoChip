module top_module (
    input a,
    input b,
    output sum,
    output cout
);

	assign {sum, cout} = a + b;

endmodule
