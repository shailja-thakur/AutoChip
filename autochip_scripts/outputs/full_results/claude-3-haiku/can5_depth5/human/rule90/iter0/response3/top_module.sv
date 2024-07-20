module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Calculate the next state of each cell based on the Rule 90 formula
        for (integer i = 0; i < 512; i++) begin
            q[i] <= (i == 0) ? 0 : q[i-1] ^ ((i == 511) ? 0 : q[i+1]);
        end
    end
end

endmodule
