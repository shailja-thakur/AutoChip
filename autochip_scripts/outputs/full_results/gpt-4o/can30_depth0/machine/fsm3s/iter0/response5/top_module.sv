module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            D: out = 1;
            default: out = 0;
        endcase
    end

endmodule
