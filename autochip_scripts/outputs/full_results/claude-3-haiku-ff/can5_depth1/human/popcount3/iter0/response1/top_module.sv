module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Instantiate a full adder to count the number of 1's
    wire [1:0] sum1, sum2;

    // First level of full adders
    full_adder fa1 (in[0], in[1], 1'b0, sum1[0], sum1[1]);
    full_adder fa2 (in[2], 1'b0, 1'b0, sum2[0], sum2[1]);

    // Second level of full adder
    full_adder fa3 (sum1[0], sum1[1], sum2[0], out[0], out[1]);

endmodule
module full_adder (
    input a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule
