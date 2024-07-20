module top_module (
    input clk,
    input d,
    output reg q
);

reg d_dff1, d_dff2;

always @(posedge clk) begin
    d_dff1 <= d;
    d_dff2 <= d_dff1;
end

always @(*) begin
    if (clk) begin
        q <= d_dff1;
    end else begin
        q <= d_dff2;
    end
end

endmodule
