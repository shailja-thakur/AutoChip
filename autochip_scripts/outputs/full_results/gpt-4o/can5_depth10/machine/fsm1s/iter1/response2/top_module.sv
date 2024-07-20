module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // Default state is B for safety
        endcase
    end

    // Sequential logic for state transitioning
    // Update state and output together in one always block
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset to initial state B
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        out <= (state == B);
    end

endmodule
