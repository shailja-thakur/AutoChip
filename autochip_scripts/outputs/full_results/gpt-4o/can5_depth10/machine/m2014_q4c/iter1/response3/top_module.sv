module top_module (
    input clk,
    input d,
    input r,
    output reg q
);

always @(posedge clk or posedge r) begin
    if (r)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
