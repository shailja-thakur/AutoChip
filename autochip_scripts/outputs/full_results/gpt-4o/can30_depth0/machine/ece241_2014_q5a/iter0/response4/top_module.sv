module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
    // Define the states
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // Register to store the current state
    reg [1:0] state, next_state;
    
    // State transition on positive edge of clock or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Set initial state to A on reset
        end else begin
            state <= next_state; // Transition to next state
        end
    end
    
    // Determine next state based on current state and input x
    always @(*) begin
        case (state)
            A: next_state = (x) ? C : A;
            B: next_state = (x) ? B : C;
            C: next_state = (x) ? B : C;
            default: next_state = A; // Default state is A
        endcase
    end
    
    // Determine output z based on the current state
    always @(*) begin
        case (state)
            C: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
