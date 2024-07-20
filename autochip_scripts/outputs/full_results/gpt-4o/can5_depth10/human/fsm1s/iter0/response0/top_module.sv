module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definitions
    typedef enum reg {A, B} state_type;
    state_type state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            B: if (in) next_state = B;
               else next_state = A;
            A: if (in) next_state = A;
               else next_state = B;
            default: next_state = B;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic (Moore machine)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end

endmodule
