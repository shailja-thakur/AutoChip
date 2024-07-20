module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data};
        end else if (count_ena) begin
            q <= q - 1;
        end
        // No action if both shift_ena and count_ena are low
    end
endmodule
