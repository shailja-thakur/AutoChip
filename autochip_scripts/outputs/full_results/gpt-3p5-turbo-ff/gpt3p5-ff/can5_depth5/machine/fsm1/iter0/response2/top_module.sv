module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0;
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        1'b0: begin
            if (in)
                next_state = 1'b0;
            else
                next_state = 1'b1;
        end
        1'b1: begin
            if (in)
                next_state = 1'b1;
            else
                next_state = 1'b0;
        end
    endcase
end

assign out = state;

endmodule
