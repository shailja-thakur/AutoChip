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
        // Advance the state by one time step
        q[0] <= ((q[511:510] == 2'b11) ? 1'b0 : (q[510] == 1'b1) ? 1'b1 : (q[511] == 1'b0) ? 1'b1 : 1'b0);
        for (int i = 1; i < 512; i++) begin
            q[i] <= ((q[i-1:i-2] == 2'b11) ? 1'b0 : (q[i-1] == 1'b1) ? 1'b1 : (q[i] == 1'b0) ? 1'b1 : 1'b0);
        end
    end
end

endmodule
