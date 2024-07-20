module top_module(
    input x,
    input y,
    output z);
    wire z;
    
    assign z = (x^y) & x;
    
endmodule
