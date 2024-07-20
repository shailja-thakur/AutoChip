module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    reg out_and;
    reg out_or;
    reg out_xor;

    always @(in) begin
        out_and = &in;
        out_or = |in;
        out_xor = ^in;
    end

endmodule
