module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State parameter definition
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // Combinational logic for next state
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
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state after reset
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
