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
        S0, // Initial state
        S1, // Seen 0
        S2, // Seen 01
        S3, // Seen 011
        S4, // Seen 0111
        S5, // Seen 01111
        S6, // Seen 011111
        S7, // Seen 0111111 (sequence for 01111110)
        S8  // Seen 01111111 (for error sequence)
    } state_t;

    state_t state, next_state;
    
    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            case (state)
                S6: // After detecting 0111111, if next bit is 0 then disc (01111110)
                    begin
                        disc <= (in == 1'b0);
                        flag <= 0;
                        err <= 0;
                    end
                S7: // After detecting 01111110, set flag
                    begin
                        disc <= 0;
                        flag <= 1;
                        err <= 0;
                    end
                S8: // After detecting 011111111..., set error (01111111...)
                    begin
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end
                default:
                    begin
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
            endcase
        end
    end
    
    // Next-state logic
    always_comb begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: // Check the 7th bit
                next_state = in ? S8 : S7; // if 0, go to S7, if 1, go to S8
            S7: // Detected 01111110 flag
                next_state = in ? S1 : S0; // Reset to new sequence
            S8: // Detected 011111111... error
                next_state = in ? S8 : S0; // Remain in error or reset on 0
            default: next_state = S0;
        endcase
    end
    
endmodule
