module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the maximum value for the BCD counter
parameter MAX_VALUE = 9999;

// Define the individual digit values
wire [3:0] ones = q[3:0];
wire [3:0] tens = q[7:4];
wire [3:0] hundreds = q[11:8];
wire [3:0] thousands = q[15:12];

// Generate the enable signals for the upper three digits
assign ena[1] = (ones == 4'd9);
assign ena[2] = (tens == 4'd9) && ena[1];
assign ena[3] = (hundreds == 4'd9) && ena[2];

// Implement the counter logic
always @(posedge clk) begin
    if (reset) begin
        q <= 16'd0;
    end
    else begin
        if (q == MAX_VALUE) begin
            q <= 16'd0;
        end
        else begin
            q[3:0]   <= (ones == 4'd9) ? 4'd0 : ones + 4'd1;
            q[7:4]   <= (ones == 4'd9) ? ((tens == 4'd9) ? 4'd0 : tens + 4'd1) : tens;
            q[11:8]  <= (ones == 4'd9 && tens == 4'd9) ? ((hundreds == 4'd9) ? 4'd0 : hundreds + 4'd1) : hundreds;
            q[15:12] <= (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9) ? ((thousands == 4'd9) ? 4'd0 : thousands + 4'd1) : thousands;
        end
    end
end

endmodule
