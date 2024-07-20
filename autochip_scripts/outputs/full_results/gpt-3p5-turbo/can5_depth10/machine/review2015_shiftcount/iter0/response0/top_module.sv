module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    reg [3:0] q_temp;

    always @(posedge clk) begin
        if (shift_ena) begin
            q_temp <= data;
        end else if (count_ena) begin
            q_temp <= q - 1;
        end
    end

    always @(posedge clk) begin
        q <= q_temp;
    end

endmodule
