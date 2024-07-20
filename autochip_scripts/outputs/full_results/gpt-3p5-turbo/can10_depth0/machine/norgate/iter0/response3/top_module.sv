module top_module(
    input a, 
    input b,
    output out
);
    // Define internal signals
    wire or_output;
    
    // Implement logical OR gate
    assign or_output = a | b;
    
    // Implement inverter
    assign out = ~or_output;
endmodule
