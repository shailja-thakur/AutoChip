module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] next_q;

always @(*) begin
    // Compute the next state of each cell using the Rule 90 formula
    for (int i = 0; i < 512; i++) begin
        next_q[i] = (i == 0) ? data[0] : ((i == 511) ? data[511] : (data[i-1] ^ data[i+1]));
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
end

endmodule
