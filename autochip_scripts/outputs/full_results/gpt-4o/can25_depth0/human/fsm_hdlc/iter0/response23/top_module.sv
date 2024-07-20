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
        S_IDLE,        // Initial/reset state
        S_ONE,         // Detected 1
        S_TWO,         // Detected 11
        S_THREE,       // Detected 111
        S_FOUR,        // Detected 1111
        S_FIVE,        // Detected 11111
        S_SIX,         // Detected 111111
        S_SEVEN        // Detected 1111111
    } state_t;

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: next_state = in ? S_ONE : S_IDLE;
            S_ONE: next_state = in ? S_TWO : S_IDLE;
            S_TWO: next_state = in ? S_THREE : S_IDLE;
            S_THREE: next_state = in ? S_FOUR : S_IDLE;
            S_FOUR: next_state = in ? S_FIVE : S_IDLE;
            S_FIVE: next_state = in ? S_SIX : S_IDLE;
            S_SIX: next_state = in ? S_SEVEN : S_IDLE;
            S_SEVEN: next_state = in ? S_SEVEN : S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

    // State transition with reset
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (state)
                S_FIVE: begin
                    if (!in) disc <= 1; // 0111110 detected
                end
                S_SIX: begin
                    if (!in) flag <= 1; // 01111110 detected
                    else err <= 1; // 01111111 or more detected
                end
                S_SEVEN: begin
                    err <= 1; // 01111111 or more detected
                end
                default: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
    end

endmodule
