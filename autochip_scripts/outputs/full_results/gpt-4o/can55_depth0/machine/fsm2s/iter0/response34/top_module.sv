module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_type;
    state_type state, next_state;

    // State transition logic based on inputs j and k
    always @(*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            out <= 0;
        end else begin
            state <= next_state;
            out <= (next_state == B);
        end
    end

endmodule
