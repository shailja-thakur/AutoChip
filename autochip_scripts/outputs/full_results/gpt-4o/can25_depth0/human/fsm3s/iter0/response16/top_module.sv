module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
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

    // State register with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

endmodule
