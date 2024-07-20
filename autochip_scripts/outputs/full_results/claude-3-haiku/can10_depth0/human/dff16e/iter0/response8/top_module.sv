module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [7:0] q_low;
reg [7:0] q_high;

always @(posedge clk) begin
    if (~resetn) begin
        q_low <= 8'b0;
        q_high <= 8'b0;
    end
    else begin
        if (byteena[0])
            q_low <= d[7:0];
        if (byteena[1])
            q_high <= d[15:8];
    end
end

always @(*) begin
    q = {q_high, q_low};
end

endmodule
