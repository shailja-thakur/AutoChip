module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Generate the out_assign using assign statement
    assign out_assign = a & b;

    // Generate the out_alwaysblock using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
