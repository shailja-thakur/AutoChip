module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {A=2'b01, B=2'b10} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) 
                    next_state = B;
               else 
                    next_state = A;
            B: if (x)
                    next_state = B;
               else
                    next_state = B;
            default: next_state = A;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
