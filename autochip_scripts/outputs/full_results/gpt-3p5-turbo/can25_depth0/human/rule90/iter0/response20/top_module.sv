module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
   
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511]       <= data[510] ^ q[0];
            q[510:1]     <= data[509:0] ^ q[511:1];
            q[0]         <= data[1] ^ q[511];
        end
    end
   
endmodule
