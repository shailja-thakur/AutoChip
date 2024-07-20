module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Using assign statement to create AND gate
    assign out_assign = a & b;

    // Using always block to create AND gate
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
