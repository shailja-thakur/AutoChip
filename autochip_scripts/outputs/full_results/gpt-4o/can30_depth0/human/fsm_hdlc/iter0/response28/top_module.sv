module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State definitions
    typedef enum reg [2:0] {
        S0,   // Initial state
        S1,   // 0 detected
        S2,   // 01 detected
        S3,   // 011 detected
        S4,   // 0111 detected
        S5,   // 01111 detected
        S6,   // 011111 detected
        S7,   // 0111111 detected
        SE    // Error state (7 or more 1s)
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        // Default values for outputs
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        
        case (state)
            S0: if (in) next_state = S1; else next_state = S0;
            S1: if (in) next_state = S2; else next_state = S0;
            S2: if (in) next_state = S3; else next_state = S0;
            S3: if (in) next_state = S4; else next_state = S0;
            S4: if (in) next_state = S5; else next_state = S0;
            S5: if (in) next_state = S6; else next_state = S0;
            S6: if (in) next_state = S7; else begin next_state = S0; disc = 1; end
            S7: if (in) begin next_state = SE; err = 1; end else begin next_state = S0; flag = 1; end
            SE: if (!in) next_state = S0; else next_state = SE;
            default: next_state = S0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
