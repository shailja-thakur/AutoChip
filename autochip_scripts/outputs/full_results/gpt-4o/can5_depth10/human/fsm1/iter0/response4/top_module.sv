module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State declarations
    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
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
            end

            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1; // Since we reset to state B which has output 1
        else begin
            if (state == STATE_B)
                out <= 1'b1;
            else
                out <= 1'b0;
        end
    end

endmodule
