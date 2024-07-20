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

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            A: if (x)
                   next_state = B;
               else
                   next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    always_comb begin
        z = 0;
        case (state)
            A: if (x)
                   z = 1;
            B: if (!x)
                   z = 1;
        endcase
    end
endmodule
