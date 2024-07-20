module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding using one-hot
    reg state_a, state_b;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_a <= 1'b1; // Move to state A on reset
            state_b <= 1'b0;
        end else begin
            state_a <= (state_a & ~x) | (state_b & x);
            state_b <= (state_a & x) | (state_b & ~x);
        end
    end

    always @(*) begin
        if (state_a) begin
            if (x) z = 1'b1;
            else z = 1'b0;
        end else if (state_b) begin
            if (x) z = 1'b0;
            else z = 1'b1;
        end
    end

endmodule
