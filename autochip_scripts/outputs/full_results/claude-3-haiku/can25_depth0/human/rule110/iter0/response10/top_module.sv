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
        q[0] <= (q[1:0] == 2'b10) | (q[1:0] == 2'b01);
        for (int i = 1; i < 511; i++) begin
            q[i] <= (q[i+1:i-1] == 3'b101) | (q[i+1:i-1] == 3'b010) | (q[i+1:i-1] == 3'b011) | (q[i+1:i-1] == 3'b100);
        end
        q[511] <= (q[511:510] == 2'b10) | (q[511:510] == 2'b01);
    end
end

endmodule
