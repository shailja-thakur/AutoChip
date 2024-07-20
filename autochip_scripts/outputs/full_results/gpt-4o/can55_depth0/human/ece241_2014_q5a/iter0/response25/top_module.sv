module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_INVERT = 2'b01,
        STATE_COPY = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry;
    reg x_delayed;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_IDLE;
            carry <= 1'b0;
            x_delayed <= 1'b0;
        end
        else begin
            state <= next_state;
            x_delayed <= x;
            if (state == STATE_INVERT) begin
                carry <= 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_IDLE: next_state = x_delayed ? STATE_INVERT : STATE_COPY;
            STATE_INVERT: next_state = STATE_COPY;
            STATE_COPY: next_state = STATE_COPY;
            default: next_state = STATE_IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_IDLE: z = 1'b0;
            STATE_INVERT: z = ~x;
            STATE_COPY: z = x;
            default: z = 1'b0;
        endcase

        if (state == STATE_INVERT && carry) begin
            z = z + 1;
        end
    end

endmodule
