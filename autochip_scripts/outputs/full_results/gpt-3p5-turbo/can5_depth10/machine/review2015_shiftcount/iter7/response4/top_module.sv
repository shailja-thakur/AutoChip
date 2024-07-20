module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (count_ena) begin
            q <= q - 1;
        end
        else if (shift_ena) begin
            q <= data;
        end
        else begin
            q <= q;
        end
    end

endmodule
