module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declaring internal registers
reg [3:0] ones, tens, hundreds, thousands;

// Combinational logic to generate enable signals
assign ena[1] = (tens == 4'd9);
assign ena[2] = (hundreds == 4'd9 && tens == 4'd9);
assign ena[3] = (thousands == 4'd9 && hundreds == 4'd9 && tens == 4'd9);

// Synchronous counter logic
always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        ones <= (ones == 4'd9) ? 0 : ones + 1;
        if (ena[1]) tens <= (tens == 4'd9) ? 0 : tens + 1;
        if (ena[2]) hundreds <= (hundreds == 4'd9) ? 0 : hundreds + 1;
        if (ena[3]) thousands <= (thousands == 4'd9) ? 0 : thousands + 1;
    end
end

// Assemble the 4-digit BCD counter value
always @* begin
    q[3:0] = ones;
    q[7:4] = tens;
    q[11:8] = hundreds;
    q[15:12] = thousands;
end

endmodule
