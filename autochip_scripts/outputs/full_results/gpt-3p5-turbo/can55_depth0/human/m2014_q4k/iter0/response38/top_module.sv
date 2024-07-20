module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] flops;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        flops <= 4'b0;
    end else begin
        flops <= {flops[2:0], in};
    end
end

assign out = flops[0];

endmodule
