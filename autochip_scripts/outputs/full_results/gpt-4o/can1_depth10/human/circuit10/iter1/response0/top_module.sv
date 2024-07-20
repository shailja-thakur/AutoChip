module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);
    reg state_reg;

    always @(posedge clk) begin
        if (a == 1 && b == 0)
            state_reg <= 0;
        else if (a == 1 && b == 1)
            state_reg <= ~state_reg;
        q <= state_reg;
    end

    assign state = state_reg;

endmodule
