module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a && b) begin
        state <= 1;
        q <= 1;
    end else if (a && !b) begin
        state <= 0;
        q <= 0;
    end else if (!a && b) begin
        state <= state;
        q <= 1;
    end else begin
        state <= state;
        q <= 0;
    end
end

endmodule
