module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire [1:0] temp;

    assign temp = a + b + cin;
    assign cout = temp[1];
    assign sum = temp[0];

endmodule
