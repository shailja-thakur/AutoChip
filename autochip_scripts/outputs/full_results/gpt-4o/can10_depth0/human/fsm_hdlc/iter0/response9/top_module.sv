module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    // State encoding
    typedef enum logic [2:0] {
        S0,  // Starting state
        S1,  // First '1' detected
        S2,  // Second '1' detected
        S3,  // Third '1' detected
        S4,  // Fourth '1' detected
        S5,  // Fifth '1' detected
        S6,  // Sixth '1' detected
        SE   // Error state if 7 '1's are detected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        // Default outputs
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S0: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S0;
                disc = 1'b1;  // Discard bit after five 1's and getting a zero
            end
            S6: begin
                if (in) next_state = SE;
                else begin
                    next_state = S0;
                    flag = 1'b1;  // Flag after six 1's and getting a zero
                end
            end
            SE: begin
                if (in) begin
                    next_state = SE;
                    err = 1'b1;  // Error state reached
                end else begin
                    next_state = S0;  // Clear error on zero
                end
            end
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

endmodule
