module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum reg [2:0] {
        S_A = 3'b000,
        S_B = 3'b001,
        S_C = 3'b010,
        S_D = 3'b011,
        S_E = 3'b100,
        S_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S_A: next_state = w ? S_B : S_A;
            S_B: next_state = w ? S_C : S_D;
            S_C: next_state = w ? S_E : S_D;
            S_D: next_state = w ? S_F : S_A;
            S_E: next_state = w ? S_E : S_D;
            S_F: next_state = w ? S_C : S_D;
            default: next_state = S_A; // Default to state S_A to cover all cases
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= S_A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        z = (state == S_E) | (state == S_F);
    end
	
endmodule
