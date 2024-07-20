module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define the states
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B;  // Default state
        endcase
    end
    
    // State update logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;  // Reset state
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end
    
endmodule
