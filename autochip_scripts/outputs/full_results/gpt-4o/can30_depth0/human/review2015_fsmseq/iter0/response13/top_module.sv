module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State declarations
    typedef enum logic [2:0] {
        S_IDLE      = 3'b000,
        S_ONE       = 3'b001,
        S_ONEONE    = 3'b010,
        S_ONEONEZERO= 3'b011,
        S_FOUND     = 3'b100
    } state_t;

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE:        next_state = data ? S_ONE : S_IDLE;
            S_ONE:         next_state = data ? S_ONEONE : S_IDLE;
            S_ONEONE:      next_state = data ? S_ONEONE : S_ONEONEZERO;
            S_ONEONEZERO:  next_state = data ? S_FOUND : S_IDLE;
            S_FOUND:       next_state = S_FOUND;
            default:       next_state = S_IDLE;
        endcase
    end

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            start_shifting <= 0;
        end 
        else begin
            state <= next_state;
            if (state == S_FOUND)
                start_shifting <= 1;
        end
    end

endmodule
