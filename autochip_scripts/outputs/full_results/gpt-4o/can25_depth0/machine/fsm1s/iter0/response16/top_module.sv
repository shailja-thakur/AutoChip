module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state;
    reg next_state;

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: if (in)
                    next_state = A;
               else
                    next_state = B;
            B: if (in)
                    next_state = B;
               else
                    next_state = A;
            default: next_state = A;
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= (state == B);
    end

endmodule
