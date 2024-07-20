module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg next_state;

    always @(posedge clk) begin
        state <= next_state;
    end

    always @(*) begin
        if (a == 0)
            next_state = state;
        else
            next_state = ~b;

        q = state;
    end

endmodule
