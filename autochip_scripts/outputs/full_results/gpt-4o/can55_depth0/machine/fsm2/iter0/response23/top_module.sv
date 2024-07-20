module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // Define state encoding
    typedef enum reg [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
    
    // Declare the state variable
    reg state, next_state;
    
    // Combinational always block to determine next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end
    
    // Clocked always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
endmodule
