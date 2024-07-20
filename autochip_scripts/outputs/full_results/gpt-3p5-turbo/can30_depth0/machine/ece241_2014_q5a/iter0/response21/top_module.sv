module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 2'b00;   // Define state A
parameter B = 2'b01;   // Define state B
parameter C = 2'b10;   // Define state C

reg [1:0] state;       // Register to store state

always @(posedge clk or areset)
begin
    if (areset)       // Reset signal triggered
        state <= A;   // Set state to A
    else              // Reset signal not triggered
        case (state)
            A: if (x)   // State A, check input x
                   state <= C;   // Set state to C if x is true
               else
                   state <= A;   // Otherwise, stay at A
            B: if (x)   // State B, check input x
                   state <= B;   // Set state to B if x is true
               else
                   state <= C;   // Otherwise, set state to C
            C: if (x)   // State C, check input x
                   state <= B;   // Set state to B if x is true
               else
                   state <= C;   // Otherwise, stay at C
        endcase
end

assign z = (state == C) ? 1'b1 : 1'b0;   // Output true if state is C, false otherwise

endmodule
