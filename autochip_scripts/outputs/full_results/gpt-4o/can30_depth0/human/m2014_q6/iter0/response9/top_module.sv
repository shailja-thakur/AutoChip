module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_A : STATE_B;
            STATE_B: next_state = (w) ? STATE_D : STATE_C;
            STATE_C: next_state = (w) ? STATE_D : STATE_E;
            STATE_D: next_state = (w) ? STATE_A : STATE_F;
            STATE_E: next_state = (w) ? STATE_D : STATE_E;
            STATE_F: next_state = (w) ? STATE_D : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= STATE_A;
        else 
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A, STATE_B, STATE_C, STATE_D, STATE_F: z = 0;
            STATE_E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
