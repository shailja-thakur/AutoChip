module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declarations using one-hot encoding
    reg state_A, state_B;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 'A' 
            state_A <= 1;
            state_B <= 0;
        end
        else begin
            // Default state transition 
            state_A <= 0;
            state_B <= 0;

            if (state_A) begin
                if (x) begin
                    state_B <= 1;
                end else begin
                    state_A <= 1;
                end
            end
            else if (state_B) begin
                state_B <= 1;
            end
        end
    end

    // Output logic
    always @(*) begin
        if (state_A) begin
            z = x;
        end
        else if (state_B) begin
            z = ~x;
        end
    end

endmodule
