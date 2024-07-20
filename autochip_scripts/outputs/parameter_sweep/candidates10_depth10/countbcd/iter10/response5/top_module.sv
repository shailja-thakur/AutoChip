module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        q <= 16'd0;
        ena <= 3'b000;
    end else begin
        if(ena[1])
            q[3:0] <= q[3:0] + 4'b1;
        if(ena[2] && q[3:0] == 4'b1001) begin
            q[3:0] <= 4'b0;
            q[7:4] <= q[7:4] + 4'b1;
            ena[1] <= 1'b0;
        end
        if(ena[3] && q[7:4] == 4'b1001) begin
            q[7:4] <= 4'b0;
            q[11:8] <= q[11:8] + 4'b1;
            ena[2] <= 1'b0;
        end
        if(q[11:8] == 4'b1001) begin
            q[11:8] <= 4'b0;
            q[15:12] <= q[15:12] + 4'b1;
            ena[3] <= 1'b0;
        end
    end
end

endmodule
