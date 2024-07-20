module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Use an assign statement to generate the out_assign output
    assign out_assign = a & b;

    // Use an always block to generate the out_alwaysblock output
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
