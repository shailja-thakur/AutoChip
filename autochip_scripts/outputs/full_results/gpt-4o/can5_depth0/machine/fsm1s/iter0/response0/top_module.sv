module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define parameters for states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Register to store the current state
    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;  // Default state
        endcase
    end

    // Sequential logic block triggered on the rising edge of the clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;  // Reset to state B
        end else begin
            state <= next_state;  // Update state to next state
        end
    end

    // Output logic, out is high when in state B
    always @(state) begin
        out = (state == B);
    end
    
endmodule
