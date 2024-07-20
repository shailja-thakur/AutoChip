module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        if (ones == 9) begin
            ones <= 0;
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        if (ena[1]) begin
            if (tens == 9) begin
                tens <= 0;
                ena[2] = 1'b1;
            end
            else begin
                tens <= tens + 1;
                ena[2] = 1'b0;
            end
        end

        if (ena[2]) begin
            if (hundreds == 9) begin
                hundreds <= 0;
                ena[3] = 1'b1;
            end
            else begin
                hundreds <= hundreds + 1;
                ena[3] = 1'b0;
            end
        end

        if (ena[3]) begin
            if (thousands == 9) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1;
            end
        end
    end

    q = {thousands, hundreds, tens, ones};
end

endmodule
