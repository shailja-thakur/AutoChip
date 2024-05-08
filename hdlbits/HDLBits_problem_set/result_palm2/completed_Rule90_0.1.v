module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    reg [511:0] q;
    reg [511:0] d;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q ^ (q[1:0]);
        end
    end

    assign d = q[511:0];

endmodule