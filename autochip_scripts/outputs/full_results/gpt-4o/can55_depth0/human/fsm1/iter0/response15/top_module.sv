module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1; // Output is 1 in STATE_B
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 0; // Output is 0 in STATE_A
            end
            default: begin
                next_state = STATE_B;
                out = 1;
            end
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

endmodule
