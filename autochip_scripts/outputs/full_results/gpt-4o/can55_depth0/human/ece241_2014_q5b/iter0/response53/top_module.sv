module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot
    reg state_A, state_B;
    reg next_state_A, next_state_B;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state A
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            // Transitions to the next state
            state_A <= next_state_A;
            state_B <= next_state_B;
        end
    end

    always @(*) begin
        // Default state assignments
        next_state_A = state_A;
        next_state_B = state_B;

        if (state_A) begin
            if (x) begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
            end
        end else if (state_B) begin
            if (~x) begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
            end else begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
            end
        end
    end

    // Output logic
    assign z = (state_A & x) | (state_B & ~x);

endmodule
