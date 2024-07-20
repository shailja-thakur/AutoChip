module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] d;
reg [3:0] q;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        d <= 4'b0000;
        q <= 4'b0000;
    end else begin
        d <= {in, q[3:1]};
        q <= d;
    end
end

assign out = q[0];

endmodule
