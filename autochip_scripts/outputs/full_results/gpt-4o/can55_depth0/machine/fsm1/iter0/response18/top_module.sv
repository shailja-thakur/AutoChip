module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    typedef enum reg { A, B } state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B;  // Default state
        endcase
    end

    assign out = (state == B);

endmodule
