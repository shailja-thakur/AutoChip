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
        if(q[3:0] == 4'd9 && ena[1]) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'b0;
            ena[2] <= 1'b1;
        end else if(q[7:4] == 4'd9 && ena[2]) begin
            q[7:4] <= 4'd0;
            ena[2] <= 1'b0;
            ena[3] <= 1'b1;
        end else if(q[11:8] == 4'd9 && ena[3]) begin
            q[11:8] <= 4'd0;
            ena[3] <= 1'b0;
        end else if(q[15:12] == 4'd9) begin
            q[15:12] <= 4'd0;
        end else begin
            q <= q + 16'd1;
        end
    end
end

endmodule
