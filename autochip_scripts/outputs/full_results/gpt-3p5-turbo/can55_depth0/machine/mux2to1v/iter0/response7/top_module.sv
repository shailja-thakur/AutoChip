module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
    // Wire to store the output value
    wire [99:0] mux_out;

    // Multiplexer implementation
    assign mux_out = sel ? b : a;
    
    // Assigning the output
    assign out = mux_out;

endmodule
