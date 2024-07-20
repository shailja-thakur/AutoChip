module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    assign out_assign = a & b; // AND operation using assign statement

    always @(*) begin
        out_alwaysblock = a & b; // AND operation using always block
    end

endmodule
