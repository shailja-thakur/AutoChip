module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 16'b0000;
        else if (ena[1] && q[3:0] == 4'b1001)
            q[3:0] <= 4'b0000;
        else
            q[3:0] <= q[3:0] + ena[1]; // Increment the ones digit

        if (ena[1] && q[3:0] == 4'b0000 && ena[2] && q[7:4] == 4'b1001)
            q[7:4] <= 4'b0000;
        else
            q[7:4] <= q[7:4] + (ena[2] && q[3:0] == 4'b0000); // Increment the tens digit

        if (ena[2] && q[7:4] == 4'b0000 && ena[3] && q[11:8] == 4'b1001)
            q[11:8] <= 4'b0000;
        else
            q[11:8] <= q[11:8] + (ena[3] && q[7:4] == 4'b0000); // Increment the hundreds digit

        if (ena[3] && q[11:8] == 4'b0000)
            q[15:12] <= 4'b0000;
        else
            q[15:12] <= q[15:12] + (ena[3] && q[11:8] == 4'b0000); // Increment the thousands digit
    end
    
    always @(posedge clk) begin
        if (reset)
            ena <= 3'b000;
        else
            ena <= ena; // Hold the enable signals stable
    end
endmodule
