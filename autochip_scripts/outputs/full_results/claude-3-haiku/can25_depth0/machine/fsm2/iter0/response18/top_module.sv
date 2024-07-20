module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State definitions
parameter A = 1'b0, B = 1'b1;

// Next state logic
always @(*) begin
    case (state)
        A: next_state = (j) ? B : A;
        B: next_state = (k) ? A : B;
        default: next_state = A;
    endcase
end

// State update
always @(posedge clk or negedge areset) begin
    if (~areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

// Output logic
always @(*) begin
    out = (state == B);
end

endmodule
