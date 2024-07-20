module top_module(
    input clk,
    input reset,
    output reg[2:0] ena,
    output reg[15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end
        else begin
            if (ena[0])
                q[3:0] <= q[3:0] + 1;
            if (ena[1])
                q[7:4] <= q[7:4] + 1;
            if (ena[2])
                q[11:8] <= q[11:8] + 1;
            if (q[3:0] == 9)   // Carry out from ones digit
                ena[0] <= 1;
            else
                ena[0] <= 0;

            if (q[7:4] == 9 && ena[0])   // Carry out from tens digit and enable ones digit increment
                ena[1] <= 1;
            else
                ena[1] <= 0;

            if (q[11:8] == 9 && ena[1])  // Carry out from hundreds digit and enable tens digit increment
                ena[2] <= 1;
            else
                ena[2] <= 0;

            if (q[15:12] == 9 && ena[2])  // Carry out from thousands digit and enable hundreds digit increment
                q <= 0;   // Reset to 0 when thousands digit reaches 9
        end
    end

endmodule
