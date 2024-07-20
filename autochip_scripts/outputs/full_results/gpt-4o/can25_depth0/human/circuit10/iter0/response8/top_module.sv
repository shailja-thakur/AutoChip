module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg state_reg;

    always @(posedge clk) begin
        if (a && b)
            state_reg <= ~state_reg;
        else if (a && !b)
            state_reg <= 1'b0;
        else if (!a && b)
            state_reg <= 1'b1;
        else
            state_reg <= state_reg;
    end

    assign q = state_reg;
    assign state = state_reg;

endmodule
