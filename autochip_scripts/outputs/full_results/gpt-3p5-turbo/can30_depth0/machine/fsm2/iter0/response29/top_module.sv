module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

always @* begin
    case(state)
        A:
            if(j)
                next_state = B;
            else
                next_state = A;
        B:
            if(k)
                next_state = A;
            else
                next_state = B;
    endcase
end

always @(posedge clk) begin
    if(areset)
        state <= A;
    else
        state <= next_state;
end

always @(posedge clk)
    out <= (state == B) ? 1'b1 : 1'b0;

endmodule
