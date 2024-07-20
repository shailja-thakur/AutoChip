module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declaration
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // Output logic based on state
    always @(state) begin
        case (state)
            STATE_A: z = 0;
            STATE_B: z = 0;
            STATE_C: z = 0;
            STATE_D: z = 0;
            STATE_E: z = 1;
            STATE_F: z = 1;
            default: z = 0;
        endcase
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (w) ? STATE_A : STATE_B;
            STATE_B: next_state = (w) ? STATE_D : STATE_C;
            STATE_C: next_state = (w) ? STATE_D : STATE_E;
            STATE_D: next_state = (w) ? STATE_A : STATE_F;
            STATE_E: next_state = (w) ? STATE_D : STATE_E;
            STATE_F: next_state = (w) ? STATE_D : STATE_C;
            default: next_state = STATE_A;
        endcase
    end
    
    // State register (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end
endmodule
