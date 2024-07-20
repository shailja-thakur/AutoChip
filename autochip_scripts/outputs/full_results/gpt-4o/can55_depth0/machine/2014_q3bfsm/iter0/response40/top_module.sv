module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;
    
    state_t state, next_state;
    
    // Sequential block for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= STATE_A;  // On reset, go to state A
        else 
            state <= next_state;
    end
    
    // Combinational block for next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = x ? STATE_B : STATE_A;
            STATE_B: next_state = x ? STATE_E : STATE_B;
            STATE_C: next_state = x ? STATE_B : STATE_C;
            STATE_D: next_state = x ? STATE_C : STATE_B;
            STATE_E: next_state = x ? STATE_E : STATE_D;
            default: next_state = STATE_A;
        endcase
    end
    
    // Combinational block for output logic
    always @(*) begin
        case (state)
            STATE_D, STATE_E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
