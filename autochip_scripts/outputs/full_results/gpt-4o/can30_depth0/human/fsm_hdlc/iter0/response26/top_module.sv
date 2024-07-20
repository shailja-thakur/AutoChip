module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State Encoding
    typedef enum reg [2:0] {
        S0,  // Initial State or after reset
        S1,  // After seeing 0
        S2,  // After seeing 01
        S3,  // After seeing 011
        S4,  // After seeing 0111
        S5,  // After seeing 01111
        S6,  // After seeing 011111
        S7,  // After seeing 0111111 (six 1s)
        S8   // Error state (seven or more 1s)
    } state_t;

    // State register
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S8 : S0;
            S8: next_state = in ? S8 : S0;  // Remain in S8 on additional 1s
            default: next_state = S0;
        endcase
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
            case (current_state)
                S6: if (!in) disc <= 1'b1;  // 0111110
                S7: if (!in) flag <= 1'b1;  // 01111110
                S8: err <= 1'b1;            // 01111111...
            endcase
        end
    end
endmodule
