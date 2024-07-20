module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (count_ena) begin
            if (q == 4'b0000) begin
                q <= 4'b1111;
            end else begin
                q <= q - 1;
            end
        end

        if (shift_ena) begin
            q[0] <= data;
            q[3:1] <= q[2:0];
        end
    end

endmodule
