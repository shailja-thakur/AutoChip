module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
        endcase
    end

    // State memory (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            B: out = 1;
            A: out = 0;
        endcase
    end
endmodule
