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
        out_reg <= 1'b1;
    else if (data[2] && data[1] && data[0])
        out_reg <= 1'b0;
    else
        out_reg <= out_reg; // Added for the case when none of the conditions are met
end

assign out = out_reg;

endmodule
