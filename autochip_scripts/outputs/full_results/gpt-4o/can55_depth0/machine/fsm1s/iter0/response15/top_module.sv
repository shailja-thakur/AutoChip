module top_module (
    input  clk,
    input  in,
    input  reset,
    output out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

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
            default: next_state = B; // Default state
        endcase
    end

    // Sequential logic to update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B) ? 1 : 0;

endmodule
