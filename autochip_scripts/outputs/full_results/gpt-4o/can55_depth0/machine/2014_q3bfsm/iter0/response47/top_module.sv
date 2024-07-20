module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (x) ? STATE_B : STATE_A;
            STATE_B: next_state = (x) ? STATE_E : STATE_B;
            STATE_C: next_state = (x) ? STATE_B : STATE_C;
            STATE_D: next_state = (x) ? STATE_C : STATE_B;
            STATE_E: next_state = (x) ? STATE_E : STATE_D;
            default: next_state = STATE_A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            STATE_D, STATE_E: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
