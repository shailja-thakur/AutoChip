module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    
    // Define the states
    parameter A = 1'b0, B = 1'b1;
    
    // Register to hold the current state
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: next_state = B;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic to update current state
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end
    
    // Output logic
    assign z = ((state == A) & x) | ((state == B) & ~x);
    
endmodule
