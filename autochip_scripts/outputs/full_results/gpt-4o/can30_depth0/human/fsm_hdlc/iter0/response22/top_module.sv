module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8} state_t;
    state_t state, next_state;

    // State transition logic (Moore FSM)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S3 : S0;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S5 : S0;
            S5: next_state = (in) ? S6 : S0;
            S6: next_state = (in) ? S8 : (in) ? S7 : S0; // in high goes to error state
            S7: next_state = (in) ? S2 : S0; // transition back after 6 ones
            S8: next_state = S8;  // Stay in error state once 7 ones detected
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
            case (state)
                S6: if (!in) disc <= 1'b1; // 0111110 detected
                S7: if (!in) flag <= 1'b1; // 01111110 detected
                S8: err <= 1'b1; // 01111111... detected
            endcase
        end
    end
endmodule
