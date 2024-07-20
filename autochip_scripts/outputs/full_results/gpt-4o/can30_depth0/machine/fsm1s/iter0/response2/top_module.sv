module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    always @(*) begin
        case(state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    assign out = (state == B);

endmodule
