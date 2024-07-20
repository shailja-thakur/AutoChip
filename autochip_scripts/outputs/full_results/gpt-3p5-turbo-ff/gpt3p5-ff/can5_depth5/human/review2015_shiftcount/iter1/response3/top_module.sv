module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

    reg [3:0] shift_q;

    always @(posedge clk) begin
        if (shift_ena & ~count_ena) begin
            shift_q <= {data, shift_q[3:1]};
        end
        else if (count_ena & ~shift_ena) begin
            shift_q <= shift_q - 1;
        end
    end

    always @(*) begin
        q = shift_q;
    end

endmodule
