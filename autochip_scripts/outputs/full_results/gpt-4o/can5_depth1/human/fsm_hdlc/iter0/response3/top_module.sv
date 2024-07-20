module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        IDLE,
        ONE,
        TWO,
        THREE,
        FOUR,
        FIVE,
        SIX,
        SEVEN
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= (state == FIVE && in == 1'b0);
            flag <= (state == SIX && in == 1'b0);
            err <= (state == SIX && in == 1'b1);
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE:   next_state = in ? ONE : IDLE;
            ONE:    next_state = in ? TWO : IDLE;
            TWO:    next_state = in ? THREE : IDLE;
            THREE:  next_state = in ? FOUR : IDLE;
            FOUR:   next_state = in ? FIVE : IDLE;
            FIVE:   next_state = in ? SIX : (in ? ONE : IDLE);
            SIX:    next_state = in ? SEVEN : IDLE;
            SEVEN:  next_state = in ? SEVEN : IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
