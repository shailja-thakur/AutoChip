module top_module(
    input in,
    output out
);
    
    wire not_out;
    assign not_out = ~in;
    assign out = not_out;
    
endmodule
