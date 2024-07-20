module top_module(
    input clk,
    input d,
    output reg q
);

reg temp_q;

always @(posedge clk) begin
    q <= d;
end

always @(negedge clk) begin
    temp_q <= d;
end

always @(posedge clk or negedge clk) begin
    if (clk) begin
        q <= q;
    end else begin
        q <= temp_q;
    end
end

endmodule
