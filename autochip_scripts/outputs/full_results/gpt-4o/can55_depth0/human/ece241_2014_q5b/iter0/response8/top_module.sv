module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
    // State encoding: one-hot
    reg state_a, state_b;
    
    // State Definitions
    parameter A = 2'd0;
    parameter B = 2'd1;
    
    // State Register update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_a <= 1'b1;
            state_b <= 1'b0;
        end else begin
            case ({state_a, state_b})
                2'b10: begin // Current state A
                    if (x)
                        {state_a, state_b} <= 2'b01; // Transition to B
                    else
                        {state_a, state_b} <= 2'b10; // Remain in A
                end
                2'b01: begin // Current state B
                    if (x)
                        {state_a, state_b} <= 2'b01; // Remain in B
                    else
                        {state_a, state_b} <= 2'b01; // Remain in B
                end
                default: {state_a, state_b} <= 2'b10; // Default to state A
            endcase
        end
    end
    
    // Output logic
    always @(*) begin
        case ({state_a, state_b})
            2'b10: z = x;    // State A: z = x
            2'b01: z = ~x;   // State B: z = ~x
            default: z = 1'b0; // Default case
        endcase
    end
endmodule
