module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones;
reg [3:0] tens;
reg [3:0] hundreds;
reg [3:0] thousands;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
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

        if (ena[1] && tens == 9) begin
            tens <= 0;
            ena[2] = 1'b1;
        end
        else if (ena[1]) begin
            tens <= tens + 1;
            ena[2] = 1'b0;
        end

        if (ena[2] && hundreds == 9) begin
            hundreds <= 0;
            ena[3] = 1'b1;
        end
        else if (ena[2]) begin
            hundreds <= hundreds + 1;
            ena[3] = 1'b0;
        end

        if (ena[3] && thousands == 9) begin
            thousands <= 0;
        end
        else if (ena[3]) begin
            thousands <= thousands + 1;
        end

        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
