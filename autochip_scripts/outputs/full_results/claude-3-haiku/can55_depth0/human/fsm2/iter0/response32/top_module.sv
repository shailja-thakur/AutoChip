module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

reg state;
parameter OFF = 1'b0, ON = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= OFF;
    else begin
        case (state)
            OFF: begin
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            end
            ON: begin
                if (k)
                    state <= OFF;
                else
                    state <= ON;
            end
        endcase
    end
end

assign out = state;

endmodule
