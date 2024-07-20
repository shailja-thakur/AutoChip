module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    // State declarations
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    // State variables
    state_t current_state, next_state;

    // Output logic
    assign z = (current_state == E || current_state == F);

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = (w ? A : B);
            B: next_state = (w ? D : C);
            C: next_state = (w ? D : E);
            D: next_state = (w ? A : F);
            E: next_state = (w ? D : E);
            F: next_state = (w ? D : C);
            default: next_state = A; // Default state should never be reached
        endcase
    end
endmodule
