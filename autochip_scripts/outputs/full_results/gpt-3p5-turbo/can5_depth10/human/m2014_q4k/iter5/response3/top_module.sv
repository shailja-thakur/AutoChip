module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] data;
reg out_reg;
reg [3:0] data_reg;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        data <= 4'b0;
    else
        data <= {data[2:0], in};
end

always @(posedge clk) begin
    if (~resetn)
        data_reg <= 4'b0;
    else
        data_reg <= data;
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        out_reg <= 1'b0;
    else if (data_reg[3])
        out_reg <= 1'b1;
    else if (data_reg[2] & data_reg[1] & data_reg[0])
        out_reg <= 1'b0;
end

assign out = out_reg;

endmodule
