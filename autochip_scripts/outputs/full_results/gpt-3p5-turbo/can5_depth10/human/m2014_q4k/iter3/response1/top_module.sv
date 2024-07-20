module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] data_reg;
reg out_reg;

always @(posedge clk or negedge resetn) begin
    if (resetn == 1'b0) begin
        data_reg <= 4'b0;
        out_reg <= 1'b0;
    end else begin
        data_reg <= {data_reg[2:0], in};
        out_reg <= data_reg[3];
    end
end

assign out = out_reg;

endmodule
