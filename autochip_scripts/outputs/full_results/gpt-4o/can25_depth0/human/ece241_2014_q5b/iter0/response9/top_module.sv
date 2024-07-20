module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            A: begin
                if (x) next_state = B;
                else next_state = A;
            end

            B: begin
                next_state = B;
            end

            default: next_state = A;
        endcase
    end

    assign z = (state == A && x) || (state == B && !x);

endmodule
