module shift_down_counter(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {data, q[3:1]};
        end else if (count_ena) begin
            q <= q - 1;
        end
    end
endmodule
module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);
    shift_down_counter counter (
        .clk (clk),
        .shift_ena (shift_ena),
        .count_ena (count_ena),
        .data (data),
        .q (q)
    );
endmodule
