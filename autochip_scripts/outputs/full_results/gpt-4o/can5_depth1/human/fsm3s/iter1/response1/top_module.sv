module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default values to avoid latches
        next_state = state;
        case (state)
            A: begin
                if (in)
                    next_state = B;
                out = 0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 0;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
                out = 0;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 1;
            end
            default: begin
                next_state = A;
                out = 0;
            end
        endcase
    end
endmodule
