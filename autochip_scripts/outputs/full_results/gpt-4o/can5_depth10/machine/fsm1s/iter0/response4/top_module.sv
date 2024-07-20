module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;  // Default state in case of erroneous state
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;  // Reset to state B
        end else begin
            state <= next_state;  // Update state
        end
    end

    // Output logic
    always @(state) begin
        out = (state == B);  // Output is high when in state B
    end
endmodule
