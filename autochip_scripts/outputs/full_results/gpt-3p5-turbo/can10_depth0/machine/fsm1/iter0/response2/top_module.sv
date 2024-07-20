module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'h1;
    else if (state == 2'h1) begin
        if (in)
            state <= 2'h1;
        else
            state <= 2'h0;
    end else begin
        if (in)
            state <= 2'h0;
        else
            state <= 2'h1;
    end
end

always @(posedge clk) begin
    if (state == 2'h0)
        out <= 1'b0;
    else
        out <= 1'b1;
end

endmodule
