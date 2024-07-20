module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a & b) begin
        state <= ~state;
        q <= state;
    end else if (a) begin
        state <= ~state;
        q <= 1;
    end else if (b) begin
        state <= 0;
        q <= 0;
    end else begin
        q <= state;
    end
end

endmodule
