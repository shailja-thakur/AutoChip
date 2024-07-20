module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // State encoding
    localparam STATE_B = 1'b1;
    localparam STATE_A = 1'b0;
    
    reg current_state, next_state;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_B;  // Reset to state B
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            default: next_state = STATE_B;  // Default state
        endcase
    end
    
    // Output logic
    assign out = (current_state == STATE_B) ? 1'b1 : 1'b0;

endmodule
