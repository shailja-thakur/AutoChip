module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;
        end else begin
            // Write to lower byte if byteena[0] is set
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
            // Write to upper byte if byteena[1] is set
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
        end
    end

endmodule
