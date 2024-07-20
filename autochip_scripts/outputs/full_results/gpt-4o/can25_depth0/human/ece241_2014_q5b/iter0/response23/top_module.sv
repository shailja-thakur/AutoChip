module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // One-hot encoded state definitions
    reg state_A, state_B;
    reg next_state_A, next_state_B;

    // Asynchronous reset to state A
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
        end
        else begin
            state_A <= next_state_A;
            state_B <= next_state_B;
        end
    end

    // Define next state logic
    always @(*) begin
        // Default state assignments
        next_state_A = state_A;
        next_state_B = state_B;

        if (state_A) begin
            if (x == 1'b0) begin
                next_state_A = 1'b1;
                next_state_B = 1'b0;
                z = 1'b0;
            end
            else begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
                z = 1'b1;
            end
        end
        else if (state_B) begin
            if (x == 1'b0) begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
                z = 1'b1;
            end
            else begin
                next_state_A = 1'b0;
                next_state_B = 1'b1;
                z = 1'b0;
            end
        end
    end

endmodule
