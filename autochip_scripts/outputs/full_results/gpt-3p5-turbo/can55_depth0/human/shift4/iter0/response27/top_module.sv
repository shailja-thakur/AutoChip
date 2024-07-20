module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

reg [3:0] shifted_q;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 4'b0000;
        shifted_q <= 4'b0000;
    end else begin
        if (load) begin
            q <= data;
            shifted_q <= data;
        end else if (ena) begin
            shifted_q[3] <= 1'b0;
            shifted_q[2:0] <= q[3:1];
            q <= shifted_q;
        end
    end
end

endmodule
