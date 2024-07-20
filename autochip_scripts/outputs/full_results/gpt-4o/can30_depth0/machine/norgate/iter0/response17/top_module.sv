module top_module(
    input a, 
    input b,
    output out
);
    // OR gate
    wire or_result;
    assign or_result = a | b;
    
    // Inverter
    assign out = ~or_result;
    
endmodule
