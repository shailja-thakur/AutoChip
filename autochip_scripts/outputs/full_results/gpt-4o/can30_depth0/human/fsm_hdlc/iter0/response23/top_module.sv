module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Initial state - 0 bits received
        S1, // 1 consecutive '1' received
        S2, // 2 consecutive '1's received
        S3, // 3 consecutive '1's received
        S4, // 4 consecutive '1's received
        S5, // 5 consecutive '1's received
        S6, // 6 consecutive '1's received
        S7  // More than 6 consecutive '1's received (Error state)
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (current_state)
                S0: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S1, S2, S3, S4, S5: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S6: begin
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                S7: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                default: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in ? S1 : S0);
            S1: next_state = (in ? S2 : S0);
            S2: next_state = (in ? S3 : S0);
            S3: next_state = (in ? S4 : S0);
            S4: next_state = (in ? S5 : S0);
            S5: next_state = (in ? S6 : S0);
            S6: next_state = (in ? S7 : S0);
            S7: next_state = (in ? S7 : S0);
            default: next_state = S0;
        endcase
    end

    // Flag detection (only when all 6 consecutive 1's have been seen already as part of S5 state)
    always @(posedge clk) begin
        if (reset) begin
            flag <= 0;
        end else if (current_state == S6 && !in) begin
            flag <= 1;
        end else begin
            flag <= 0;
        end
    end

endmodule
