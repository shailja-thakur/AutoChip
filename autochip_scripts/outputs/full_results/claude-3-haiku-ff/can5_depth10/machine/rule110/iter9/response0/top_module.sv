module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= {q[510:0], ~(q[511:510] == 2'b01)};
    end
end

endmodule
