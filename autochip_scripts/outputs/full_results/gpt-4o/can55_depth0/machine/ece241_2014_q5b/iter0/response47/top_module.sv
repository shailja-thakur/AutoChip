module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
