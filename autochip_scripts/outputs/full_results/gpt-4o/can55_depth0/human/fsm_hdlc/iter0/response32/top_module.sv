module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0,  // Initial state (previous input was as if it were 0)
        S1,  // Seen 0
        S2,  // Seen 01
        S3,  // Seen 011
        S4,  // Seen 0111
        S5,  // Seen 01111
        S6,  // Seen 011111
        S7,  // Seen 0111111
        S8   // Error state (7 or more consecutive 1s)
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S3 : S0;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S5 : S0;
            S5: next_state = (in) ? S6 : S0;
            S6: next_state = (in) ? S7 : (reset ? S0 : S4);
            S7: next_state = (in) ? S8 : (reset ? S0 : S0);
            S8: next_state = (in) ? S8 : (reset ? S0 : S0);
            default: next_state = S0;
        endcase
    end
    
    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (state)
            S6: disc = (!in) ? 1'b1 : 1'b0; // 0111110 -> need to discard
            S7: flag = (!in) ? 1'b1 : 1'b0; // 01111110 -> flag recognized
            S8: err = (in) ? 1'b1 : 1'b0;   // 01111111... -> error
            default: begin
                disc = 1'b0;
                flag = 1'b0;
                err = 1'b0;
            end
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
