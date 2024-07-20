module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire carry1, carry2, carry3;

    assign {carry1, sum} = a + b + cin;
    assign cout = carry1;

endmodule
