module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic for next state
always @(*) begin
    case (state)
        A: state = j ? B : A;
        B: state = k ? A : B;
        default: state = A;
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= state;
    end
end

// Output logic
always @(*) begin
    out = (state == B);
end

endmodule
