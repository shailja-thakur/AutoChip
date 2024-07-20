module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transitions
    always @(*) begin
        case (state)
            A: 
                if (in)
                    next_state = A;
                else
                    next_state = B;
            B: 
                if (in)
                    next_state = B;
                else
                    next_state = A;
            default: 
                next_state = B; // default to state B
        endcase
    end

    // State and output update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Asynchronous reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1; // Initial output for state B
        else
            case (state)
                A: out <= 1'b0;
                B: out <= 1'b1;
            endcase
    end

endmodule
