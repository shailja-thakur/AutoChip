module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: next_state = j ? B : A;
        B: next_state = k ? A : B;
        default: next_state = A;
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Combinational logic to set the output
always @(*) begin
    out = (state == B) ? 1'b1 : 1'b0;
end

endmodule
