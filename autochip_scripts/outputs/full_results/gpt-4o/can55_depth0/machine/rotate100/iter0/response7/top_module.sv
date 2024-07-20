module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        // If load is high, load data into q
        if (load) 
            q <= data;
        else begin
            // If ena is 2'h1, shift left
            if (ena == 2'h1)
                q <= q << 1;
            // If ena is 2'h2, shift right
            else if (ena == 2'h2)
                q <= q >> 1;
        end
    end
endmodule
