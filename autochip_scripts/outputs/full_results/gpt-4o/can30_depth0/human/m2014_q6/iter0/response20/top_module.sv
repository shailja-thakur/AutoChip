module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Declare state encoding
    typedef enum reg [2:0] {
        S_A = 3'b000,
        S_B = 3'b001,
        S_C = 3'b010,
        S_D = 3'b011,
        S_E = 3'b100,
        S_F = 3'b101
    } state_t;
    
    state_t state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_A: next_state = (w) ? S_A : S_B;
            S_B: next_state = (w) ? S_D : S_C;
            S_C: next_state = (w) ? S_D : S_E;
            S_D: next_state = (w) ? S_A : S_F;
            S_E: next_state = (w) ? S_D : S_E;
            S_F: next_state = (w) ? S_D : S_C;
            default: next_state = S_A;  // default case to handle unexpected behavior
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S_E, S_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
