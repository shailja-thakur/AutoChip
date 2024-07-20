module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the BCD digits
wire [3:0] ones = q[3:0];
wire [3:0] tens = q[7:4];
wire [3:0] hundreds = q[11:8];
wire [3:0] thousands = q[15:12];

// Generate the enable signals
assign ena[1] = (ones == 4'b1001); // Enable tens digit when ones digit is 9
assign ena[2] = (tens == 4'b1001); // Enable hundreds digit when tens digit is 9
assign ena[3] = (hundreds == 4'b1001); // Enable thousands digit when hundreds digit is 9

// Increment the BCD counter
always @(posedge clk) begin
    if (reset) begin
        q <= 16'h0000;
    end
    else begin
        // Increment the ones digit
        q[3:0] <= (ones == 4'b1001) ? 4'b0000 : ones + 1'b1;

        // Increment the tens digit
        if (ena[1]) begin
            q[7:4] <= (tens == 4'b1001) ? 4'b0000 : tens + 1'b1;
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            q[11:8] <= (hundreds == 4'b1001) ? 4'b0000 : hundreds + 1'b1;
        end

        // Increment the thousands digit
        if (ena[3]) begin
            q[15:12] <= (thousands == 4'b1001) ? 4'b0000 : thousands + 1'b1;
        end
    end
end

endmodule
