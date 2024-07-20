module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum reg {STATE_A = 0, STATE_B = 1} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                if (in == 1'b0) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_B; // Default to state B
                out = 1'b1;
            end
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end
endmodule
