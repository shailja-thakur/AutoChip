module top_module(
    input a,
    input b,
    output out
);
    
    //OR gate
    wire or_out;
    assign or_out = a | b;
    
    //Inverter
    wire inv_out;
    assign inv_out = ~or_out;
    
    //Output
    assign out = inv_out;

endmodule
