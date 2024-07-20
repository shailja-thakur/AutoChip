module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

    // Define the states as parameters
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // Default state is B
        endcase
    end

    // Sequential logic block triggered on the rising edge of clk or high reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;      // Reset to state B
        end else begin
            state <= next_state; // Update state to next state
        end
    end

    // Output logic
    always @(state) begin
        out = (state == B); // Output is high if state B
    end
    
endmodule
