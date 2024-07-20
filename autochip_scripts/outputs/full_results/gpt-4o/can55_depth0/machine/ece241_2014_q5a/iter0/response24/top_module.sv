module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // Parameters for states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    // State register
    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // If reset is active, set state to A
        else
            state <= next_state;  // Otherwise, transition to next state
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
