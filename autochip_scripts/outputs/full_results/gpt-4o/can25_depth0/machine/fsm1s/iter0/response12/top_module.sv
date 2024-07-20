module top_module (
	input clk,
	input in,
	input reset,
	output out
);
    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default case
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset state is B
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == B);

endmodule
