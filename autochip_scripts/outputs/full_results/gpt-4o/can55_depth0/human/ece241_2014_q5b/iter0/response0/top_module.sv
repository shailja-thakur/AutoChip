module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    
    reg [1:0] state, next_state; 

    // State encoding using one-hot encoding
    localparam A = 2'b01;
    localparam B = 2'b10;

    // Output logic
    assign z = (state == A && x == 1) || (state == B && x == 0);

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset to state A
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = (x) ? B : B;
            default: next_state = A;  // Default state
        endcase
    end

endmodule
