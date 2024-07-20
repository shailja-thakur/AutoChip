module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        B = 2'b01,
        A = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            B: if (in) 
                   next_state = B;
               else 
                   next_state = A;
            A: if (in) 
                   next_state = A;
               else 
                   next_state = B;
            default: next_state = B; // Default state
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
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default output state
        endcase
    end
endmodule
