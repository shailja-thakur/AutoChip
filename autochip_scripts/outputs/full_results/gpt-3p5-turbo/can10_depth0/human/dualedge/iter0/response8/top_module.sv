module top_module(
    input clk,
    input d,
    output reg q);

    reg q_temp1;
    reg q_temp2;

    always @(posedge clk) begin
        q_temp1 <= d;
    end

    always @(negedge clk) begin
        q_temp2 <= q_temp1;
        q <= q_temp2;
    end

endmodule
