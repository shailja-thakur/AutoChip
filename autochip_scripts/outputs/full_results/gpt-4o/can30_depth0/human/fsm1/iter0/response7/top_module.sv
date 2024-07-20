module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum logic [1:0] {A=2'b00, B=2'b01} state_t;
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            B: out = 1;
            A: out = 0;
        endcase
    end

endmodule
