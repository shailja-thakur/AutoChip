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
            q <= ~q;
        else if (a)
            q <= state;
        else
            q <= b;
    end

endmodule
