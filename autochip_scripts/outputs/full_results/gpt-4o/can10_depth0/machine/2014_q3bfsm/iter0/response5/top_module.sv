module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State definition
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;
    
    // Variable to hold the current state
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (x) ? STATE_B : STATE_A;
            STATE_B: next_state = (x) ? STATE_E : STATE_B;
            STATE_C: next_state = (x) ? STATE_B : STATE_C;
            STATE_D: next_state = (x) ? STATE_C : STATE_B;
            STATE_E: next_state = (x) ? STATE_E : STATE_D;
            default: next_state = STATE_A;
        endcase
    end
    
    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        case (state)
            STATE_D, STATE_E: z = 1;
            default: z = 0;
        endcase
    end
endmodule
