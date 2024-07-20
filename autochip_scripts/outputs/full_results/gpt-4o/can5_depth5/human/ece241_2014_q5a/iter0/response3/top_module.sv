module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_INVERT = 2'b01,
        STATE_ADD_ONE = 2'b10,
        STATE_DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg carry;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_IDLE;
            carry <= 1'b0;
        end else begin
            state <= next_state;
            if (state == STATE_INVERT) carry <= 1'b1;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            STATE_IDLE: next_state = (areset) ? STATE_IDLE : STATE_INVERT;
            STATE_INVERT: next_state = (areset) ? STATE_IDLE : STATE_ADD_ONE;
            STATE_ADD_ONE: next_state = (areset) ? STATE_IDLE : STATE_DONE;
            STATE_DONE: next_state = (areset) ? STATE_IDLE : STATE_DONE;
            default: next_state = STATE_IDLE;
        endcase
    end
    
    // Output logic
    always_comb begin
        case (state)
            STATE_IDLE: z = 1'b0;
            STATE_INVERT: z = ~x;
            STATE_ADD_ONE: z = x ^ carry;
            STATE_DONE: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule
