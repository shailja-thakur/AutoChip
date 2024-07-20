module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        q <= 16'h0000;
        ena <= 3'b000;
    end else begin
        if(ena[1]) begin
            if(q[3:0] == 4'h9)
                q[3:0] <= 4'h0;
            else
                q[3:0] <= q[3:0] + 4'h1;
        end
        if(ena[2]) begin
            if(q[7:4] == 4'h9) begin
                q[7:4] <= 4'h0;
                ena[1] <= 1'b1;
            end else
                q[7:4] <= q[7:4] + 4'h1;
        end
        if(ena[3]) begin
            if(q[11:8] == 4'h9) begin
                q[11:8] <= 4'h0;
                ena[2] <= 1'b1;
            end else
                q[11:8] <= q[11:8] + 4'h1;
        end
        if(ena[4]) begin
            if(q[15:12] == 4'h9) begin
                q[15:12] <= 4'h0;
                ena[3] <= 1'b1;
            end else
                q[15:12] <= q[15:12] + 4'h1;
        end
    end
end

endmodule
