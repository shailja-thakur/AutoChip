module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;
  
    state_t current_state, next_state;

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= STATE_B;  // Asynchronous reset to state B
        else 
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 0;
            STATE_B: out = 1;
            default: out = 1;
        endcase
    end

endmodule
