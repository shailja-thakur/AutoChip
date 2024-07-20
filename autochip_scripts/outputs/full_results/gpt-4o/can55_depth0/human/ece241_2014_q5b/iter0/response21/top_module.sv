module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot
    reg state_A, state_B;

    // Combination logic to generate output based on current state and input x
    always @(*) begin
        if (state_A) begin
            z = x ? 1'b1 : 1'b0;
        end else if (state_B) begin
            z = x ? 1'b0 : 1'b1;
        end else begin
            z = 1'b0; // Default value (shouldn't be reached)
        end
    end

    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset: Reset to state A
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            if (state_A) begin
                state_A <= x ? 1'b0 : 1'b1;
                state_B <= x ? 1'b1 : 1'b0;
            end else if (state_B) begin
                state_A <= 1'b0;
                state_B <= 1'b1;
            end
        end
    end
endmodule
