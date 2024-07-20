module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

always @(*) begin
    case (state)
        A: next_state = (j) ? B : A;
        B: next_state = (k) ? A : B;
    endcase
end

always @(posedge clk) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
