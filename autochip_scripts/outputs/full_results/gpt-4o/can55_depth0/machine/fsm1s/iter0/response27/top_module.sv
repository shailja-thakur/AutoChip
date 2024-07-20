module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
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
            default: next_state = A; // This should never happen
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
