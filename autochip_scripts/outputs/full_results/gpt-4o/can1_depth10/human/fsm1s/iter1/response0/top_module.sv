module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition and output logic (combinational)
    always @(*) begin
        case(state)
            B: begin
                out = 1;
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                out = 0;
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: begin
                out = 1;
                next_state = B;  // in case of unexpected state, reset to B
            end
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= B;    // Reset state
        else
            state <= next_state;
    end

endmodule
