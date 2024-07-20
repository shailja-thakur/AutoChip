module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

reg [7:0] d_low;
reg [7:0] d_up;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        d_low <= 8'b0;
        d_up <= 8'b0;
    end else begin
        if (byteena[0])
            d_low <= d[7:0];
        if (byteena[1])
            d_up <= d[15:8];
    end
end

always @(posedge clk)
    if (!resetn)
        q <= 16'b0;
    else begin
        q[7:0] <= d_low;
        q[15:8] <= d_up;
    end

endmodule
