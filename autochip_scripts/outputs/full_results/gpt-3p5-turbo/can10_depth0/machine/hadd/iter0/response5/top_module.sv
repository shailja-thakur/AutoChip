module top_module (
	input a,
	input b,
	output sum,
	output cout
);
    reg [31:0] sum;
    reg cout;

    always @(a or b) begin
        {cout, sum} = a + b;
    end
endmodule
