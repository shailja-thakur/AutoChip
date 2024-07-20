module top_module(
    output reg zero /* assign zero as constant value */
);

    always @(*) begin
        zero = 0;
    end

endmodule
