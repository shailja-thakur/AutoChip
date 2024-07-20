module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: state = j ? B : A;
        B: state = k ? A : B;
        default: state = A;
    endcase
end

// Sequential logic to update the current state
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= state;
end

// Assign the output based on the current state
always @(*) begin
    out = (state == B) ? 1'b1 : 1'b0;
end

endmodule
