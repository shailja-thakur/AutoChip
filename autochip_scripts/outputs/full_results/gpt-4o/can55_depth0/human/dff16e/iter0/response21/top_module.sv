module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'h0000;  // Synchronous reset, active low
        end
        else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8];  // Write to upper byte if byteena[1] is asserted
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];  // Write to lower byte if byteena[0] is asserted
            end
        end
    end
    
endmodule
