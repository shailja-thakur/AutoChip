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
        else if (ena[2] && q[7:4] == 4'b1001)
            q[7:4] <= 4'b0000;
        else if (ena[3] && q[11:8] == 4'b1001)
            q[11:8] <= 4'b0000;
        else
            q <= q + 1;
    end

    always @(posedge clk) begin
        if (reset)
            ena <= 3'b000;
        else begin
            if (q[3:0] == 4'b1001 && q[7:4] != 4'b1001)
                ena[2] <= 1'b1;
            else if (q[7:4] == 4'b1001 && q[11:8] != 4'b1001)
                ena[3] <= 1'b1;
            else
                ena <= ena;
        end
    end

endmodule
