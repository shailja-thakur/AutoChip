module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);

    always @(in) begin
        out_and = reduce(and, in);
        out_or = reduce(or, in);
        out_xor = reduce(xor, in);
    end

endmodule