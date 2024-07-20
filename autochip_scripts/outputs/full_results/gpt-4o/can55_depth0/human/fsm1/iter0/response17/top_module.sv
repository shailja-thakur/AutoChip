module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum reg { A, B } state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: if (in) next_state = B;
               else next_state = A;
            A: if (in) next_state = A;
               else next_state = B;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;  // asynchronously reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
        endcase
    end

endmodule
