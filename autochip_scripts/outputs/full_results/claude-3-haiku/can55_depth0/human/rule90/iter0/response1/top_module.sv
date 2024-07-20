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
        // Calculate the next state of each cell using the Rule 90 logic
        q[0] <= q[511] ^ q[1];
        for (int i = 1; i < 511; i++) begin
            q[i] <= q[i-1] ^ q[i+1];
        end
        q[511] <= q[510] ^ 1'b0; // Boundary condition, q[512] is always 0
    end
end

endmodule
