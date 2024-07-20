module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_B: if (in) 
                        next_state = STATE_B;
                     else 
                        next_state = STATE_A;
            STATE_A: if (in)
                        next_state = STATE_A;
                     else
                        next_state = STATE_B;
            default: next_state = STATE_B;
        endcase
    end
    
    // State flip-flops with synchronous reset (sequential)
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic (Moore machine output only dependent on current state)
    always @(*) begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule
