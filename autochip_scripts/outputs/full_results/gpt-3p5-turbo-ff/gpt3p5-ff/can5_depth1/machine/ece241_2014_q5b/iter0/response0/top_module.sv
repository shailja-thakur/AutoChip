module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Parameter definition
parameter A = 1;  // State A
parameter B = 2;  // State B

// State register
reg [1:0] state;

always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= A; // Set state to A when areset is asserted
    else
    begin
        case (state)
            A:  if (x == 1) state <= B; // Transition from A to B if x is 1
                else state <= A;       // Remain in state A
            B:  state <= B;             // Remain in state B
        endcase
    end
end

// Output assignment
assign z = (state == A && x == 1) || (state == B && x == 0) ? 1'b1 : 1'b0;

endmodule
