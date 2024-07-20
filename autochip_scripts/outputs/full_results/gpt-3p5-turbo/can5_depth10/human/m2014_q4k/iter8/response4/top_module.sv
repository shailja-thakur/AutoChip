module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

reg [3:0] data;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        data <= 4'b0;
    else
        data <= {data[2:0], in};
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        out <= 1'b0;
    else
        out <= data[3] ? (data[2] & data[1] & data[0]) ? ~out : out : out;
end

endmodule
