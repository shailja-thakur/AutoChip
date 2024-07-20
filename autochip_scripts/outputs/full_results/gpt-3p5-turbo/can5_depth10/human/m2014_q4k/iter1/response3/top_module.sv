module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] data;
wire out_reg;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        data <= 4'b0;
    else
        data <= {data[2:0], in};
end

assign out_reg = data[3];
assign out = ~out_reg;

endmodule
