module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declarations
    typedef enum reg [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? A : B;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? D : E;
            D: next_state = (w) ? A : F;
            E: next_state = (w) ? D : E;
            F: next_state = (w) ? D : C;
            default: next_state = A; // Default state
        endcase
    end

    // Combinational logic for output z
    always @(*) begin
        case (current_state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
