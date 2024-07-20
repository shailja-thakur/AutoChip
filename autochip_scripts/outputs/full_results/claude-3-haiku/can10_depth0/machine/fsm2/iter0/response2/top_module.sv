module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine next state
always @(state, j, k) begin
    case (state)
        A: state = (j) ? B : A;
        B: state = (k) ? A : B;
        default: state = A;
    endcase
end

// Sequential logic to update state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= state;
    end
end

// Output logic
always @(state) begin
    out = (state == B) ? 1'b1 : 1'b0;
end

endmodule
