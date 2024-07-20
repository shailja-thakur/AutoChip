module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg state_A, state_B;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state A
            state_A <= 1;
            state_B <= 0;
        end else begin
            // State transitions
            if (state_A) begin
                if (x) begin
                    state_A <= 0;
                    state_B <= 1;
                end
            end else if (state_B) begin
                if (!x) begin
                    state_B <= 1;
                    state_A <= 0;
                end
            end
        end
    end

    always @(*) begin
        // Output logic
        if (state_A) begin
            z = x;
        end else if (state_B) begin
            z = ~x;
        end else begin
            z = 0; // Default value if states are invalid
        end
    end

endmodule
