module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    
    assign sum = a ^ b;
    assign cout = a & b;
    
endmodule
