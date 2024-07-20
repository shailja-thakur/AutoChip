module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1'b1 && b == 1'b0) begin
        state <= 1'b0;
        q <= 1'b1;
    end else if (a == 1'b0 && b == 1'b1) begin
        state <= 1'b0;
        q <= 1'b1;
    end else if (a == 1'b1 && b == 1'b1) begin
        state <= 1'b1;
        q <= 1'b0;
    end else begin
        state <= state; // retain state
        q <= q; // retain q
    end
end

endmodule
