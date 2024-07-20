module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // Parameter definitions for the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    
    // Register to hold the state
    reg [1:0] state, next_state;

    // State transition based on current state and input x
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A;
        endcase
    end

    // Sequential logic for state update based on clock and reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
