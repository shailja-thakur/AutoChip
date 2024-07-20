module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a && b)
            state <= 1'b0;
        else if (a)
            state <= !state;
        q <= state;
    end

endmodule
