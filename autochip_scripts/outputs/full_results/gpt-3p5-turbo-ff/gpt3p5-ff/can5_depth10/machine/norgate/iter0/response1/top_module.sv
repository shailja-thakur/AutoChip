module top_module(
    input a, 
    input b,
    output out
);

    wire or_output;
    reg inv_output;
    
    assign or_output = a | b;
    always @(or_output)
        inv_output = ~or_output;
    
    assign out = inv_output;
    
endmodule
