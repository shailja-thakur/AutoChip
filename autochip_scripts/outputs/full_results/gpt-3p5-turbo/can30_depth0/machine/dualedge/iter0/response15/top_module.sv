module top_module(
    input clk,
    input d,
    output reg q
);

always @(posedge clk) begin
    qp <= d;
end

always @(negedge clk) begin
    qn <= d;
end

always @(clk) begin
    if (clk == 1'b1) begin
        q <= qp;
    end else begin
        q <= qn;
    end
end

endmodule
