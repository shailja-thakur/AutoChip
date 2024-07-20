module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum logic [2:0] {
        S0, // Initial state / after reset - behaves as if previous input were 0
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7, // 0111111 (1 more for detection)
        S8  // Error state for 01111111...
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        // Next state logic
        case (state)
            S0: begin
                next_state = in ? S1 : S0;
            end
            S1: begin
                next_state = in ? S2 : S0;
            end
            S2: begin
                next_state = in ? S3 : S0;
            end
            S3: begin
                next_state = in ? S4 : S0;
            end
            S4: begin
                next_state = in ? S5 : S0;
            end
            S5: begin
                next_state = in ? S6 : S0;
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    next_state = S0;
                    disc = 1; // 0111110 detected
                end
            end
            S7: begin
                if (in) begin
                    next_state = S8;
                end else begin
                    next_state = S0;
                    flag = 1; // 01111110 detected
                end
            end
            S8: begin
                next_state = in ? S8 : S0;
                err = 1; // 01111111... detected
            end
            default: next_state = S0;
        endcase
    end

endmodule
