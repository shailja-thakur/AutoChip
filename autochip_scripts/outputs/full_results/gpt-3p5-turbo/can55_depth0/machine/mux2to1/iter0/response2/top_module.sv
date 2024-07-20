module top_module (
    input a,
    input b,
    input sel,
    output out
);

    // Logic for the multiplexer
    assign out = (sel == 1'b1) ? b : a;

endmodule
