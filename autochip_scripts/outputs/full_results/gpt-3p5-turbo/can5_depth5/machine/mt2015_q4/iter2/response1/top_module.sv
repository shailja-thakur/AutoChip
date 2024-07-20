module top_module(
    input x,
    input y,
    output z);

    wire a, b;
    
    assign a = x & y;
    assign b = y & x;
    assign z = a & b;
    
endmodule
