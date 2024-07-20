module full_adder (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
