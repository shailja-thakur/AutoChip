module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= q;
        if (a & b)
            q <= !q;
        else if (a & !b)
            q <= 1'b0;
        else if (!a & b)
            q <= 1'b1;
        else
            q <= q;
    end

endmodule
