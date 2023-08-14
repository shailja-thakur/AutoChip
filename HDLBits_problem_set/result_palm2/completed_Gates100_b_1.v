module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);

    wire [99:0] and_result;
    wire [99:0] or_result;
    wire [99:0] xor_result;

    always @(in) begin
        and_result <= and(in, in);
        or_result <= or(in, in);
        xor_result <= xor(in, in);
    end

    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;

endmodule