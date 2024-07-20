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
        case (state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

endmodule
