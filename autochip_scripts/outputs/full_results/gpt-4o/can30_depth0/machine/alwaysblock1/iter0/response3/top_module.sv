module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Using assign statement to perform logical AND operation
    assign out_assign = a & b;

    // Using always block to perform logical AND operation
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
