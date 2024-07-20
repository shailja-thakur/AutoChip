module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

reg [3:0] data;
reg [3:0] shift_reg;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        data <= 4'b0;
    else
        data <= {data[2:0], in};
end

always @(posedge clk) begin
    if (resetn)
        shift_reg <= data;
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        out <= 1'b0;
    else if (shift_reg[3])
        out <= 1'b1;
    else
        out <= 1'b0;
end

endmodule
