module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define states using an enumerated type
    typedef enum logic [1:0] {
        B = 1'b0,
        A = 1'b1
    } state_t;
    
    // Declare state registers
    state_t state, next_state;

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            B: next_state = (in ? B : A);
            A: next_state = (in ? A : B);
            default: next_state = B; // Default/fallback case
        endcase
    end

    // Output logic (combinational)
    always_comb begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1; // Default/fallback case
        endcase
    end
    
endmodule
