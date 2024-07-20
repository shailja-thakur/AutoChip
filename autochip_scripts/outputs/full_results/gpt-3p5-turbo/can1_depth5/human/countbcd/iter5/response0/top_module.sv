module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b000;
        end else begin
            if (ena[0]) begin
                q[3:0] <= (q[3:0] == 4'b1001) ? 4'b0000 : q[3:0] + 1;
            end
            if (ena[1]) begin
                q[7:4] <= (q[7:4] == 4'b1001) ? 4'b0000 : q[7:4] + 1;
            end
            if (ena[2]) begin
                q[11:8] <= (q[11:8] == 4'b1001) ? 4'b0000 : q[11:8] + 1;
            end
            
            if (ena[0]) begin
                ena[0] <= 0;
                ena[1] <= 1;
            end else if (ena[1]) begin
                ena[1] <= 0;
                ena[2] <= 1;
            end else if (ena[2]) begin
                ena[2] <= 0;
                ena[0] <= 1;
            end else begin
                ena <= 3'b000;
            end
        end
    end

endmodule
