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
        S0, S1, S2, S3, S4, S5, S6, S7, SE
    } state_t;

    state_t state, next_state;

    // Synchronous reset logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
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
                else begin
                    next_state = S1;
                    disc = 1'b1;  // Signal a bit needs to be discarded
                end
            end
            S6: begin
                if (in) begin
                    next_state = SE;
                    err = 1'b1;  // Error condition (7 consecutive 1s)
                end else begin
                    next_state = S1;
                    flag = 1'b1;  // Flag condition (01111110)
                end
            end
            SE: begin  // Error state
                next_state = (in) ? SE : S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
