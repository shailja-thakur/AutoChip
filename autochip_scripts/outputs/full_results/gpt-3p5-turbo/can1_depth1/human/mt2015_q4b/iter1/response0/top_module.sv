module top_module(
    input x,
    input y,
    output z);
    
    wire temp;
    
    assign temp = x & !y;
    assign z = temp;
    
endmodule
