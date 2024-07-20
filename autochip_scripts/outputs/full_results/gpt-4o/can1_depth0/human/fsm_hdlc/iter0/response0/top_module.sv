module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum logic [2:0] {
        S_IDLE      = 3'b000,
        S_ONE       = 3'b001,
        S_TWO       = 3'b010,
        S_THREE     = 3'b011,
        S_FOUR      = 3'b100,
        S_FIVE      = 3'b101,
        S_SIX       = 3'b110,
        S_ERROR     = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_IDLE:    next_state = in ? S_ONE : S_IDLE;
            S_ONE:     next_state = in ? S_TWO : S_IDLE;
            S_TWO:     next_state = in ? S_THREE : S_IDLE;
            S_THREE:   next_state = in ? S_FOUR : S_IDLE;
            S_FOUR:    next_state = in ? S_FIVE : S_IDLE;
            S_FIVE:    next_state = in ? S_SIX : S_IDLE;
            S_SIX:     next_state = in ? S_ERROR : S_IDLE;
            S_ERROR:   next_state = in ? S_ERROR : S_IDLE;
            default:   next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE; // Reset to S_IDLE state.
            disc  <= 1'b0;
            flag  <= 1'b0;
            err   <= 1'b0;
        end
        else begin
            state <= next_state;
            disc  <= (state == S_FIVE && in == 1'b0);
            flag  <= (state == S_FIVE && in == 1'b1);
            err   <= (state == S_SIX && in == 1'b1);
        end
    end

endmodule
