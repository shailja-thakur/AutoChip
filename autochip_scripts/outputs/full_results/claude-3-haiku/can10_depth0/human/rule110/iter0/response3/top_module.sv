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
        q[0] <= (q[1:0] == 2'b11) ? 1'b0 : (q[1:0] == 2'b01) ? 1'b1 : (q[1:0] == 2'b10) ? 1'b1 : 1'b0;
        for (int i = 1; i < 511; i++) begin
            q[i] <= (q[i+1:i-1] == 3'b111) ? 1'b0 : (q[i+1:i-1] == 3'b110) ? 1'b1 : (q[i+1:i-1] == 3'b101) ? 1'b1 : (q[i+1:i-1] == 3'b100) ? 1'b0 : (q[i+1:i-1] == 3'b011) ? 1'b1 : (q[i+1:i-1] == 3'b010) ? 1'b1 : (q[i+1:i-1] == 3'b001) ? 1'b1 : 1'b0;
        end
        q[511] <= (q[511:510] == 2'b11) ? 1'b0 : (q[511:510] == 2'b01) ? 1'b1 : (q[511:510] == 2'b10) ? 1'b1 : 1'b0;
    end
end

endmodule
