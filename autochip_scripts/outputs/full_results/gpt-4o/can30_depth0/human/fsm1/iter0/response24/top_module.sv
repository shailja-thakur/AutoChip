module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t state, next_state;
    
    // State transition logic
    always_comb begin
        case (state)
            A: if (in)
                    next_state = A;
               else
                    next_state = B;
            B: if (in)
                    next_state = B;
               else
                    next_state = A;
            default: next_state = B;
        endcase
    end
    
    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end
    
    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1; // As state B has output 1
        else
            out <= (state == B) ? 1'b1 : 1'b0;
    end

endmodule
