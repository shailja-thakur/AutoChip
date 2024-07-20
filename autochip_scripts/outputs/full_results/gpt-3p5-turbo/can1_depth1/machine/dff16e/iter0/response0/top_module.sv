module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk)
    begin
        if (resetn == 0)  // Reset signal low, reset register to 0
            q <= 0;
        else
        begin
            if (byteena[0] == 1)  // If first bit of byte enable signal is high
                q[7:0] <= d[7:0];  // Write lower 8 bits of data to lower 8 bits of register
            if (byteena[1] == 1)  // If second bit of byte enable signal is high
                q[15:8] <= d[15:8];  // Write upper 8 bits of data to upper 8 bits of register
        end
    end

endmodule
