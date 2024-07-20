module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_ZERO       = 2'b00,
        STATE_CARRY      = 2'b01,
        STATE_NON_CARRY  = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= STATE_ZERO;
        else
            state <= next_state;
    end

    always @(posedge clk or posedge areset) begin
        if(areset)
            carry <= 1'b0;
        else if(state == STATE_ZERO)
            carry <= ~x;
    end

    always @(*) begin
        case(state)
            STATE_ZERO: begin
                z = ~x;
                if(x == 1)
                    next_state = STATE_CARRY;
                else
                    next_state = STATE_NON_CARRY;
            end
            STATE_CARRY: begin
                z = carry;
                if(x == 0)
                    next_state = STATE_NON_CARRY;
                else
                    next_state = STATE_CARRY;
            end
            STATE_NON_CARRY: begin
                z = ~x;
                if(x == 1)
                    next_state = STATE_CARRY;
                else
                    next_state = STATE_NON_CARRY;
            end
            default: begin
                z = 0;
                next_state = STATE_ZERO;
            end
        endcase
    end
endmodule
