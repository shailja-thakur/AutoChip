module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // One-hot state encoding
    reg state_A, state_B;
    reg state_A_nxt, state_B_nxt;
    
    // Asynchronous reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            state_A <= state_A_nxt;
            state_B <= state_B_nxt;
        end
    end
    
    // State transition and output logic
    always @(*) begin
        // Default values for next state and output
        state_A_nxt = state_A;
        state_B_nxt = state_B;
        z = 1'b0;

        if (state_A) begin // Current state is A
            if (x == 1'b0) begin
                state_A_nxt = 1'b1;
                state_B_nxt = 1'b0;
                z = 1'b0;
            end else begin
                state_A_nxt = 1'b0;
                state_B_nxt = 1'b1;
                z = 1'b1;
            end
        end else if (state_B) begin // Current state is B
            if (x == 1'b0) begin
                state_A_nxt = 1'b0;
                state_B_nxt = 1'b1;
                z = 1'b1;
            end else begin
                state_A_nxt = 1'b0;
                state_B_nxt = 1'b1;
                z = 1'b0;
            end
        end
    end
endmodule
