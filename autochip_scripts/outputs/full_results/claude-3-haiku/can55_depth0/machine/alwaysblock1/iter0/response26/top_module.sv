module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign output using a combinational logic assignment
    assign out_assign = a & b;

    // Assign output using an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
