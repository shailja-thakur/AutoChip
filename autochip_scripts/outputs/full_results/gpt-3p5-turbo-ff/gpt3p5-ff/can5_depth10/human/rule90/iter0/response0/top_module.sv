module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // Calculate the next state of each cell
            for (int i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    q[i] <= (q[i+1] ^ q[i+511]);
                else if (i == 511)
                    q[i] <= (q[0] ^ q[i-1]);
                else
                    q[i] <= (q[i+1] ^ q[i-1]);
            end
        end
    end
    
endmodule
