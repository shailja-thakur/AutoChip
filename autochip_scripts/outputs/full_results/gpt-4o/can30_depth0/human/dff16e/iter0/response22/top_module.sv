module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;  // Synchronous reset to zero
        end
        else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8];  // Write upper byte when byteena[1] is asserted
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];  // Write lower byte when byteena[0] is asserted
            end
        end
    end

endmodule
