module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    // State registers
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 1'b0;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_B; // Default state should be STATE_B
                out = 1'b1;
            end
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B; // Asynchronous reset to State B
        else
            state <= next_state;
    end

endmodule
