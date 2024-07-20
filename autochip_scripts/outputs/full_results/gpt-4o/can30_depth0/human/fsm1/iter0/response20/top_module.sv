module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) next_state = A; else next_state = B;
            B: if (in) next_state = B; else next_state = A;
            default: next_state = B;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic, Moore machine, output based on current state
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1;
        endcase
    end

endmodule
