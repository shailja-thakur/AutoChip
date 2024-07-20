module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [3:0] {
        S0,  // initial state
        S1,  // saw 0
        S2,  // saw 01
        S3,  // saw 011
        S4,  // saw 0111
        S5,  // saw 01111
        S6,  // saw 011111
        S7   // saw 0111111
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S0 : S1;
            S1: next_state = in ? S2 : S1;
            S2: next_state = in ? S3 : S1;
            S3: next_state = in ? S4 : S1;
            S4: next_state = in ? S5 : S1;
            S5: next_state = in ? S6 : S1;
            S6: next_state = in ? S7 : S1;
            S7: next_state = in ? S7 : S1;
            default: next_state = S0;
        endcase
    end
    
    // Output logic
    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            S6:
                if (next_state == S1) disc = 1;
            S7:
                if (next_state == S1) flag = 1;
                else err = 1;
            default: ;
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
