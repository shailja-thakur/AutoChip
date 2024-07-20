module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    reg cout;
    wire sum;
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
    
endmodule
