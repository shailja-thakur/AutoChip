module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    // Define the states
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // Combinational always block to determine the next state
    always @(*) begin
        case (state)
            STATE_A: next_state = (j) ? STATE_B : STATE_A;
            STATE_B: next_state = (k) ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end
    
    // Clocked always block to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    assign out = (state == STATE_B);

endmodule
