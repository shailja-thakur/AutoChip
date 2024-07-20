module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) 
                    next_state = A;
                else 
                    next_state = B;
            B: if (in) 
                    next_state = B;
                else 
                    next_state = A;
            default: next_state = B;  // Default state is B
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1;  // Default value for output
        endcase
    end

endmodule
