module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
    // Define states
    typedef enum reg [0:0] {A = 1'b0, B = 1'b1} state_t;
    
    // State register
    reg state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default to avoid latches
        endcase
    end
    
    // Sequential logic (state update) on rising edge of clk
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset state to B
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(state) begin
        out = (state == B);
    end
    
endmodule
