module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_OFF = 2'b00,
        STATE_ON = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic (Next state logic)
    always @(*) begin
        case (state)
            STATE_OFF: begin
                if (j)
                    next_state = STATE_ON;
                else
                    next_state = STATE_OFF;
            end
            STATE_ON: begin
                if (k)
                    next_state = STATE_OFF;
                else
                    next_state = STATE_ON;
            end
            default: next_state = STATE_OFF;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_OFF: out = 1'b0;
            STATE_ON:  out = 1'b1;
            default:   out = 1'b0;
        endcase
    end

endmodule
