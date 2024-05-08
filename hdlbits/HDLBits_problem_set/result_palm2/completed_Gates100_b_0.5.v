module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);

    wire [99:0] and_result;
    wire [99:0] or_result;
    wire [99:0] xor_result;

    always @(in or and_result or or_result or xor_result) begin
        and_result <= in & and_result;
        or_result <= in | or_result;
        xor_result <= in ^ xor_result;
    end

    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;

endmodule