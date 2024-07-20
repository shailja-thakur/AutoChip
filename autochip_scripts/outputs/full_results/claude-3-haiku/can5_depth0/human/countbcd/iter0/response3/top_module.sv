module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 4'b0000;
        tens <= 4'b0000;
        hundreds <= 4'b0000;
        thousands <= 4'b0000;
        q <= 16'b0000000000000000;
    end
    else begin
        if (ones == 4'b1001) begin
            ones <= 4'b0000;
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] = 1'b0;
        end

        if (ena[1] == 1'b1) begin
            if (tens == 4'b1001) begin
                tens <= 4'b0000;
                ena[2] = 1'b1;
            end
            else begin
                tens <= tens + 1'b1;
                ena[2] = 1'b0;
            end
        end

        if (ena[2] == 1'b1) begin
            if (hundreds == 4'b1001) begin
                hundreds <= 4'b0000;
                ena[3] = 1'b1;
            end
            else begin
                hundreds <= hundreds + 1'b1;
                ena[3] = 1'b0;
            end
        end

        if (ena[3] == 1'b1) begin
            if (thousands == 4'b1001) begin
                thousands <= 4'b0000;
            end
            else begin
                thousands <= thousands + 1'b1;
            end
        end

        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
