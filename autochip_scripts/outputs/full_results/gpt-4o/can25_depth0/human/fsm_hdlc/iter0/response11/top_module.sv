module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State declaration
    typedef enum logic [2:0] {
        S0,  // Initial state
        S1,  // 0
        S2,  // 01
        S3,  // 011
        S4,  // 0111
        S5,  // 01111
        S6,  // 011111
        S7,  // 0111111
        S8   // 01111110, for flagging frame boundary
    } state_t;
    
    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always_comb begin
        // Default assignments
        disc = 0;
        flag = 0;
        err = 0;
        next_state = state;

        case (state)
            S1: begin
                if (in) next_state = S1;
                else next_state = S2;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S2;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S2;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S2;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S2;
            end
            S6: begin
                if (in) next_state = S7;
                else next_state = S8;
            end
            S7: begin
                if (in) next_state = S7; // Error state remains in S7
                else begin
                    next_state = S2;
                    err = 1;
                end
            end
            S8: begin
                if (in) begin
                    next_state = S1;
                    flag = 1;
                end else begin
                    next_state = S1;
                    disc = 1;
                end
            end
            default: next_state = S1;
        endcase
    end

endmodule
