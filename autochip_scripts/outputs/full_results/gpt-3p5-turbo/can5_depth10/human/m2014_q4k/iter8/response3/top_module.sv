module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
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
    else
        out_reg <= (data[3] == 1'b1) || ((data[2] == 1'b1) && (data[1] == 1'b1) && (data[0] == 1'b1)) ? ~out_reg : out_reg;
end

always @(posedge clk) begin
    if (resetn == 1'b0)
        out <= 1'b0;
    else
        out <= out_reg;
end

// Add initial block to set initial values
initial begin
    data <= 4'b0;
    out_reg <= 1'b0;
end

endmodule
