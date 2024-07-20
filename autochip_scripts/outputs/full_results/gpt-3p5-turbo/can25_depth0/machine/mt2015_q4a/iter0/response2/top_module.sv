module top_module(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x; // Logical AND operation between XOR of x and y, and x
    
endmodule
