module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign statement to generate out_assign
    assign out_assign = a & b;

    // Always block triggered by any change in inputs
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
