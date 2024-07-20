module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        S0,  // Initial state, previous bit was 0
        S1,  // Detected 1 consecutive 1
        S2,  // Detected 2 consecutive 1s
        S3,  // Detected 3 consecutive 1s
        S4,  // Detected 4 consecutive 1s
        S5,  // Detected 5 consecutive 1s
        S6,  // Detected 6 consecutive 1s (possible flag state)
        S7,  // Detected 7 consecutive 1s (error state)
        S8   // Detected 0 after 5 consecutive 1s (discard state)
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= (current_state == S8);
            flag <= (current_state == S6 && in == 1'b0);
            err <= (current_state == S7);
        end
    end

    always_comb begin
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S8; // 6 ones end in 1 => error, end in 0 => flag or discard
            S7: next_state = in ? S7 : S0; // error state remains in error for any further 1s
            S8: next_state = in ? S1 : S0; // discard state goes back to S0 if next bit is 0
            default: next_state = S0;
        endcase
    end
endmodule
