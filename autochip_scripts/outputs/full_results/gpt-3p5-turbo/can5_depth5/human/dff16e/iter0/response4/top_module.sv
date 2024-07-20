module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [7:0] d_low;
reg [7:0] d_high;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        d_low <= 8'd0;
        d_high <= 8'd0;
    end else begin
        if (byteena[0])
            d_low <= d[7:0];
        if (byteena[1])
            d_high <= d[15:8];
    end
end

always @(posedge clk) begin
    if (~resetn) begin
        q <= 16'd0;
    end else begin
        q[7:0] <= d_low;
        q[15:8] <= d_high;
    end
end

endmodule
