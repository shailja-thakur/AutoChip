module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Decode the enable signals for the upper three digits
assign ena[1] = (q[3:0] == 4'b1001); // Ones digit rolls over
assign ena[2] = (q[7:4] == 4'b1001); // Tens digit rolls over
assign ena[3] = (q[11:8] == 4'b1001); // Hundreds digit rolls over

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the counter
        if (ena[1]) q[3:0] <= 4'b0000;
        else q[3:0] <= q[3:0] + 1'b1;

        if (ena[1] && ena[2]) q[7:4] <= 4'b0000;
        else if (ena[1]) q[7:4] <= q[7:4] + 1'b1;

        if (ena[1] && ena[2] && ena[3]) q[11:8] <= 4'b0000;
        else if (ena[1] && ena[2]) q[11:8] <= q[11:8] + 1'b1;

        if (ena[1] && ena[2] && ena[3] && (q[15:12] == 4'b1001)) q[15:12] <= 4'b0000;
        else if (ena[1] && ena[2] && ena[3]) q[15:12] <= q[15:12] + 1'b1;
    end
end

endmodule
