module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    reg [3:0] q;
    reg [3:0] d;

    always @(posedge clk) begin
        if (shift_ena) begin
            d <= data;
            q <= q >> 1;
            q[0] <= d[3];
        end else if (count_ena) begin
            q <= q - 1;
        end
    end

endmodule