module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0, // Initial state, last bit was '0'
        S1, // Last bit was '1'
        S2, // Last two bits were '11'
        S3, // Last three bits were '111'
        S4, // Last four bits were '1111'
        S5, // Last five bits were '11111'
        S6, // Last six bits were '111111'
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state; // Default, stays in the current state
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S3 : S0;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S5 : S0;
            S5: next_state = (in) ? S6 : S0;
            S6: next_state = (in) ? S6 : S0; // Error state if 7 or more consecutive 1s occur
            default: next_state = S0; // catch unforeseen state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
            case (next_state)
                S0: ; // No specific output
                S1: ; // No specific output
                S2: ; // No specific output
                S3: ; // No specific output
                S4: ; // No specific output
                S5: disc <= (in == 1'b0) ? 1'b1 : 1'b0; // 0111110 detected
                S6: begin
                    if (in == 1'b0) begin
                        flag <= 1'b1; // 01111110 detected
                    end else begin
                        err <= 1'b1; // More than 6 consecutive 1s detected
                    end
                end
            endcase
        end
    end

endmodule
