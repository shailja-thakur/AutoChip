module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);

    always @(in) begin
        out_and = in & in;
        out_or = in | in;
        out_xor = in ^ in;
    end

endmodule