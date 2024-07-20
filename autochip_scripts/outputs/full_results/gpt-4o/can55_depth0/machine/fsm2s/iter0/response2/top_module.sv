module top_module(
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (j) next_state = STATE_B;
                else next_state = STATE_A;
            end
            STATE_B: begin
                if (k) next_state = STATE_A;
                else next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end
    
    // Output logic
    assign out = (current_state == STATE_B);

endmodule
