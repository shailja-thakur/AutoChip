module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign the result of logical AND using assign statement
    assign out_assign = a & b;

    // Always block for continuous logic with sensitivity list
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
