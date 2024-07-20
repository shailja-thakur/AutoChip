module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        A: next_state = j ? B : A;
        B: next_state = k ? A : B;
        default: next_state = A;
    endcase
end

// Sequential logic to update the current state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    out = (state == B) ? 1'b1 : 1'b0;
end

endmodule
