module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum logic [2:0] {
        S0, // State for 0 previous consecutive 1s or reset
        S1, // State for 1 consecutive 1s
        S2, // State for 2 consecutive 1s
        S3, // State for 3 consecutive 1s
        S4, // State for 4 consecutive 1s
        S5, // State for 5 consecutive 1s
        S6, // State for 6 consecutive 1s (possibly leading to flag or disc)
        S7  // State for 7 or more consecutive 1s (leads to error)
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state; // Default stay in the same state
        disc = 0;
        flag = 0;
        err = 0;

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
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S0; // 0111110 -> discard a bit
                    disc = 1;
                end
            end
            S7: begin
                if (in) next_state = S7; // Remain in Error state
                else begin
                    next_state = S0; // 01111110 -> flag a frame boundary
                    flag = 1;
                end
                err = 1; // error occurs with seven or more 1s
            end
        endcase
    end

endmodule
