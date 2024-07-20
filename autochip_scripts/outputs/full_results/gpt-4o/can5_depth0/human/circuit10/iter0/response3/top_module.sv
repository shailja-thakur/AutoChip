module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (b == 1) begin
        q <= 1;
        state <= 1;
    end else if (a == 1) begin
        q <= 0;
        state <= 0;
    end else begin
        q <= state;
    end
end

endmodule
