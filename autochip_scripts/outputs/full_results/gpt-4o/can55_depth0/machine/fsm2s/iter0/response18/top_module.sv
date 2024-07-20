module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;  // Reset state to A
        else 
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case(state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;  // Default state
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case(state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
