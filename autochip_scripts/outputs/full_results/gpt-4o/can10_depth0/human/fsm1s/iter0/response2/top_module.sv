module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum logic [0:0] {
        A = 0,
        B = 1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B;
        endcase
    end

    // State register update
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 1;
        endcase
    end
endmodule
