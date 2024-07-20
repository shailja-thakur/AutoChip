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
        1'b0: next_state = j ? 1'b1 : 1'b0;
        1'b1: next_state = k ? 1'b0 : 1'b1;
        default: next_state = 1'b0;
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    out = state;
end

endmodule
