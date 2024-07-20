module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (b)
            q <= a;
        else
            q <= state;

        state <= q;
    end

endmodule
