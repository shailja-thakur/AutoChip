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
        else begin
            q[3:0] <= q[3:0] + 4'b0001;
            q[7:4] <= (q[7:4] + (q[3:0] == 4'b0000)) ? 4'b0000 : q[7:4];
            q[11:8] <= ((q[7:4] == 4'b0000) & (q[3:0] == 4'b0000)) ? 4'b0000 : q[11:8];
        end
    end

    always @(posedge clk) begin
        if (reset)
            ena <= 3'b000;
        else begin 
            ena[1] <= (q[3:0] == 4'b1001) ? 1'b0 : 1'b1;
            ena[2] <= (q[7:4] == 4'b1001) ? 1'b0 : 1'b1;
            ena[3] <= (q[11:8] == 4'b1001) ? 1'b0 : 1'b1;
        end
    end

endmodule
