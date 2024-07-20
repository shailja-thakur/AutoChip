module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j && k) begin
        Q <= ~Q;
    end else if (~j && k) begin
        Q <= 0;
    end else if (j && ~k) begin
        Q <= 1;
    end
end

endmodule
