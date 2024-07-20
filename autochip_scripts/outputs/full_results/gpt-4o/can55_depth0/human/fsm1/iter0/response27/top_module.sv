module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    // State Encoding
    typedef enum reg [0:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // State Transition
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B; // Default reset state
        endcase
    end

    // State Flip-Flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1;
        endcase
    end

endmodule
