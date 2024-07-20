module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B;  // Default state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic (Moore model: output depends only on state)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
