module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    reg out_and;
    reg out_or;
    reg out_xor;
    
    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;

endmodule
