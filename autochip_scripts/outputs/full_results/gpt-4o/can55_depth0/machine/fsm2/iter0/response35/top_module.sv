module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State declarations
    typedef enum reg {A, B} state_t;
    state_t current_state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (current_state)
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

    // Clocked always block to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (current_state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
