module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign output using the assign statement
    assign out_assign = a & b;

    // Assign output using the always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
