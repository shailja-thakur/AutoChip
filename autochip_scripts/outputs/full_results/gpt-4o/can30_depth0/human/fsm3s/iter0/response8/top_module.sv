module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    
    // State encoding
    typedef enum reg [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10,
        S_D = 2'b11
    } state_t;
    
    // State registers
    reg [1:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S_A: next_state = (in) ? S_B : S_A;
            S_B: next_state = (in) ? S_B : S_C;
            S_C: next_state = (in) ? S_D : S_A;
            S_D: next_state = (in) ? S_B : S_C;
            default: next_state = S_A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S_D: out = 1;
            default: out = 0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S_A;
        else
            current_state <= next_state;
    end

endmodule
