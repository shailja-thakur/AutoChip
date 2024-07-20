module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign statement to perform logical AND and assign to out_assign
    assign out_assign = a & b;

    // Always block to perform logical AND and assign to out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
