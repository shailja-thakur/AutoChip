module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] data;
reg out_reg;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        data <= 4'b0;
    else
        data <= {data[2:0], in};
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        out_reg <= 1'b0;
    else if (data[3])
        out_reg <= out_reg;
    else
        out_reg <= data[0];
end

assign out = out_reg;

endmodule
