module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end

    // State update and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
