module top_module(
    input wire clk,
    input wire shift_ena,
    input wire count_ena,
    input wire [0:3] data,
    output reg [3:0] q);

    reg [3:0] q_reg;

    always @(posedge clk) begin
        if (shift_ena) begin
            q_reg <= data;
        end else if (count_ena) begin
            q_reg <= q_reg - 1;
        end
    end

    always @(posedge clk) begin
        q <= q_reg;
    end

endmodule
