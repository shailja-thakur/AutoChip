module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;
    
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

    // State flip-flops with synchronous reset (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end
endmodule
