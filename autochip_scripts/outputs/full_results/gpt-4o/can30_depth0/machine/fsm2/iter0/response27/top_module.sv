module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encodings
    parameter STATE_A = 1'b0;
    parameter STATE_B = 1'b1;
    
    // State variables
    reg state, next_state;
    
    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            STATE_A: if (j) next_state = STATE_B;
                     else next_state = STATE_A;
            STATE_B: if (k) next_state = STATE_A;
                     else next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // Clocked always block to update state and output
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
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
