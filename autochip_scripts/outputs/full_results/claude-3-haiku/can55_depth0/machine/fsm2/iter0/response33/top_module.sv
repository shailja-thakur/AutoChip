module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

// Combinational block to determine next state
always @(*) begin
    case (state)
        A: state = j ? B : A;
        B: state = k ? A : B;
        default: state = A;
    endcase
end

// Clocked block to update state and output
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        out <= 1'b0;
    end
    else begin
        state <= state;
        out <= (state == B) ? 1'b1 : 1'b0;
    end
end

endmodule
