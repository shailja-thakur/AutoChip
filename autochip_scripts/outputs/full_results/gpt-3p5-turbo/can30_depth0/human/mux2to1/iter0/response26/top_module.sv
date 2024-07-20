module top_module (
    input a,
    input b,
    input sel,
    output out
);

    wire temp_out;
    
    // 2-to-1 multiplexer logic
    assign temp_out = (sel) ? b : a;
    
    // Output of the multiplexer
    assign out = temp_out;

endmodule
