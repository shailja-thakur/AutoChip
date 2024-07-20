module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // One-hot encoding for states
    reg state_A, state_B, next_A, next_B;

    // State transition logic
    always @(*) begin
        // Default next state values
        next_A = 0;
        next_B = 0;
        z = 0;
        
        // State transitions and output logic
        case (1'b1)  // Synopsys parallel_case
            state_A: begin
                if (x == 0) begin
                    next_A = 1;
                    z = 0;
                end else begin
                    next_B = 1;
                    z = 1;
                end
            end
            state_B: begin
                if (x == 0) begin
                    next_B = 1;
                    z = 1;
                end else begin
                    next_B = 1;
                    z = 0;
                end
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1;
            state_B <= 0;
        end else begin
            state_A <= next_A;
            state_B <= next_B;
        end
    end

endmodule
