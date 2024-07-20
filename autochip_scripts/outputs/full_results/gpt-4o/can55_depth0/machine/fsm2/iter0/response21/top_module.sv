module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State declaration
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // Combinational always block for next state logic
    always @(*) begin
        case (state)
            A: if (j) 
                  next_state = B;
               else 
                  next_state = A;
            B: if (k) 
                  next_state = A;
               else 
                  next_state = B;
            default: next_state = A; // Default state to A
        endcase
    end

    // Clocked always block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (state == B);
    end
endmodule
