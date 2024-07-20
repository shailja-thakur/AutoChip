module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

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
            default: begin
                next_state = A; // Default to A for safety
            end
        endcase
    end

    // Sequential logic to update state register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
