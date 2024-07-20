module top_module(
    input wire clk, 
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q[0] <= data[1] ^ data[510];
    
        for (int i = 1; i < 511; i = i + 1) begin
            q[i] <= data[i-1] ^ data[i+1];
        end
    
        q[511] <= data[510] ^ data[0];
    end

endmodule
