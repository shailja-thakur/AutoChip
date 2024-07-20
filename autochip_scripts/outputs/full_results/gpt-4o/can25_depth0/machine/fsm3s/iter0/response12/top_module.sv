module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg [1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            A: if (in)
                   next_state = B;
               else
                   next_state = A;
            B: if (in)
                   next_state = B;
               else
                   next_state = C;
            C: if (in)
                   next_state = D;
               else
                   next_state = A;
            D: if (in)
                   next_state = B;
               else
                   next_state = C;
            default: next_state = A;
        endcase
    end

    always @(*) begin
        if (state == D)
            out = 1;
        else
            out = 0;
    end

endmodule
