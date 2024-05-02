module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    reg [15:0] d1, d2;

    always @(posedge clk or negedge resetn) begin
        if (resetn) begin
            d1 <= 16'h0;
            d2 <= 16'h0;
        end else begin
            if (byteena[1]) begin
                d1 <= d[15:8];
            end else begin
                d1 <= 16'h0;
            end
            if (byteena[0]) begin
                d2 <= d[7:0];
            end else begin
                d2 <= 16'h0;
            end
            q <= d1 | d2;
        end
    end

endmodule