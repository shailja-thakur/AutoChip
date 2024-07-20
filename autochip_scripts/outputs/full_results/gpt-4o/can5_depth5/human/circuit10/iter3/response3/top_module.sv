module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a && b) begin
        state <= ~state;
    end else if (a && !b) begin
        state <= 1'b0;
    end else if (!a && b) begin
        state <= 1'b1;
    end
    q <= state;
end

endmodule
