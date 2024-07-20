module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // Current state register
    reg state, next_state;

    // Combinational logic block for next state logic
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

            default: next_state = A;
        endcase
    end

    // Sequential logic block (triggered on the rising edge of the clock)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
