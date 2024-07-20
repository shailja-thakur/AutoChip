module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational always block to determine the next state
    always @(*) begin
        case (state)
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
            default: next_state = A;  // Default choice to avoid latches
        endcase
    end

    // Clocked always block to update the state based on clk and areset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0;  // Default choice to avoid latches
        endcase
    end
endmodule
