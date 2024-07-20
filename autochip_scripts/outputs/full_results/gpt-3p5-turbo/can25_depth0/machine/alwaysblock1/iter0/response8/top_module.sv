module top_module(
    input a,
    input b,
    output out_assign,
    output out_alwaysblock
);

    assign out_assign = a & b;
    
    always @(a, b) begin
        out_alwaysblock = a & b;
    end

endmodule
