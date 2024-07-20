module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    typedef enum reg [1:0] {
        S0, // Initial state, output depends on input
        S1  // State after seeing first 1, output inverted from now on
    } state_t;
    
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            S0: begin
                if (x == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                next_state = S1; // Remain in S1 once we are in S1.
            end
            default: next_state = S0;
        endcase
    end
    
    always @(*) begin
        case (state)
            S0: z = x;        // Output the input directly until we see a 1
            S1: z = ~x;       // Invert the input after seeing the first 1
            default: z = x;
        endcase
    end
endmodule
