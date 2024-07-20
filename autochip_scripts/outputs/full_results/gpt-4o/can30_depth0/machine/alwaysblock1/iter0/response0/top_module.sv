module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Generate the output using an assign statement
    assign out_assign = a & b;

    // Generate the output using an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
