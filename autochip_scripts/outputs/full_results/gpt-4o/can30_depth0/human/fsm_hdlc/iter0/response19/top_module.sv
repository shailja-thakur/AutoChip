module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State declaration
    typedef enum reg [2:0] {
        S0,  // No 1's seen
        S1,  // 1 one seen
        S2,  // 2 ones seen
        S3,  // 3 ones seen
        S4,  // 4 ones seen
        S5,  // 5 ones seen
        S6,  // 6 ones seen (possible discard)
        S7   // 7 ones seen (error)
    } state_t;

    state_t current_state, next_state;

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (current_state)
                S6: if (in == 0) disc <= 1; else disc <= 0;
                S7: err <= (in == 1);
                default: begin
                    disc <= 0;
                    flag <= (current_state == S6 && in == 1);
                    err <= 0;
                end
            endcase
        end
    end

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;  // Remain in error state if 1 continues
            default: next_state = S0;
        endcase
    end

endmodule
