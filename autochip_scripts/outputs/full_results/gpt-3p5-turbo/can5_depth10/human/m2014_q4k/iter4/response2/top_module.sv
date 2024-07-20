module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] data;
reg out_reg;
reg clk_prev;

always @(posedge clk) begin
    data <= {data[2:0], in};
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        out_reg <= 1'b0;
    else if (data[3] && !clk_prev)
        out_reg <= 1'b1;
    else
        out_reg <= 1'b0;

    clk_prev <= clk;
end

assign out = out_reg;

endmodule
