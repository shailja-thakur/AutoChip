module top_module (
    input a,
    input b,
    input sel,
    output out
);
    // Declare internal signals
    wire mux_out;

    // Create a multiplexer
    assign mux_out = (sel == 1'b1) ? b : a;

    // Assign the output
    assign out = mux_out;

endmodule
