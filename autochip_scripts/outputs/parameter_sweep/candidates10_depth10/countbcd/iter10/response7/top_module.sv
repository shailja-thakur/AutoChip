module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        q <= 16'd0;
        ena <= 3'b0;
    end else begin
        if(ena[1] == 1'b1 && q[3:1] != 3'b011) begin
            ena <= ena + 1;
            q <= q + 1;
        end else if (ena[1] == 1'b1 && q[3:1] == 3'b011) begin
            ena <= 3'b0;
            q[3:1] <= 3'b000;
        end else if (ena[2] == 1'b1 && q[7:4] != 4'b0111) begin
            ena <= ena + 1;
            q <= q + 1;
        end else if (ena[2] == 1'b1 && q[7:4] == 4'b0111) begin
            ena[1] <= 1'b1;
            ena[2] <= 1'b0;
            q[7:4] <= 4'b0000;
        end else if (ena[3] == 1'b1 && q[11:8] != 4'b0111) begin
            ena <= ena + 1;
            q <= q + 1;
        end else if (ena[3] == 1'b1 && q[11:8] == 4'b0111) begin
            ena[2] <= 1'b1;
            ena[3] <= 1'b0;
            q[11:8] <= 4'b0000;
        end else if (q[15:12] != 4'b0111) begin
            ena <= ena + 1;
            q <= q + 1;
        end else if (q[15:12] == 4'b0111) begin
            ena[3] <= 1'b1;
            q[15:12] <= 4'b0000;
        end
    end
end

endmodule
