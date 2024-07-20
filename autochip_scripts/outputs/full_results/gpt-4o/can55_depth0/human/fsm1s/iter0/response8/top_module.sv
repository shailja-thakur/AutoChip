module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            B: if (in) 
                   next_state = B;
               else 
                   next_state = A;
            A: if (in) 
                   next_state = A;
               else 
                   next_state = B;
            default: next_state = B; // Default to reset state for safe measure
        endcase
    end

    // Output logic based on current state
    always_ff @(posedge clk) begin
        if (reset)
            out <= 1;
        else begin
            case (state)
                B: out <= 1;
                A: out <= 0;
                default: out <= 1; // Default to reset state output
            endcase
        end
    end
endmodule
