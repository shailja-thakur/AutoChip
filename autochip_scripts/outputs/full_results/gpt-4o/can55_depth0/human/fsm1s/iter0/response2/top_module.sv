module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {B, A} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: if (in) next_state = B;
               else next_state = A;
            A: if (in) next_state = A;
               else next_state = B;
            default: next_state = B; // default state (should not happen)
        endcase
    end
   
    // State update logic (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic (Moore machine)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // default output (should not happen)
        endcase
    end

endmodule
