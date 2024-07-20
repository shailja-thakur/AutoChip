module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block for next state determination
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // Default state if somehow in an undefined state
        endcase
    end

    // Sequential block for state update on rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset state to B
        end else begin
            state <= next_state; // Update state
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
