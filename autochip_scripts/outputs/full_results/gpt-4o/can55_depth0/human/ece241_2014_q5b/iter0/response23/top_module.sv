module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding (one-hot)
    reg state_A, state_B;
    
    // Sequential state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1;
            state_B <= 0;
        end
        else begin
            if (state_A) begin
                if (x) begin
                    state_A <= 0;
                    state_B <= 1;
                end
                // else case implies stay in state_A (default values already set)
            end
            else if (state_B) begin
                if (x) begin
                    state_B <= 1;  // Stay in state_B
                end
                else begin
                    state_B <= 1;  // Stay in state_B
                end
            end
        end
    end
    
    // Output logic
    always @(*) begin
        if (state_A) begin
            z = x;  // A --x=0 (z=0)--> A, A --x=1 (z=1)--> B
        end
        else if (state_B) begin
            z = ~x;  // B --x=0 (z=1)--> B, B --x=1 (z=0)--> B
        end
    end

endmodule
