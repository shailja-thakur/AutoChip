module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define states
parameter A = 1'b1;
parameter B = 1'b01;

// Registers for current state and next state
reg [1:0] current_state;
reg [1:0] next_state;

// Combinational logic for next state
always @(*) begin
    case (current_state)
        A: if (x) next_state = B;
           else next_state = A;
        B: if (x) next_state = B;
           else next_state = B;
        default: next_state = A;
    endcase
end

// Sequential logic for current state
always @(posedge clk or posedge areset) begin
    if (areset) current_state <= A;
    else current_state <= next_state;
end

// Output logic
assign z = (current_state == B);

endmodule
