module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end else begin
            if (ena[1] && q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[1] <= 1'b0;
                ena[2] <= 1'b1;
                ena[3] <= 1'b0;
            end else if (ena[2] && q[7:4] == 4'd9) begin
                q[7:4] <= 4'd0;
                ena[1] <= 1'b1;
                ena[2] <= 1'b0;
                ena[3] <= 1'b1;
            end else if (ena[3] && q[11:8] == 4'd9) begin
                q[11:8] <= 4'd0;
                ena[1] <= 1'b1;
                ena[2] <= 1'b1;
                ena[3] <= 1'b0;
            end else begin
                ena[1] <= 1'b1;
                ena[2] <= 1'b1;
                ena[3] <= 1'b1;
                if (ena[1])
                    q[3:0] <= q[3:0] + 1;
                if (ena[2])
                    q[7:4] <= q[7:4] + 1;
                if (ena[3])
                    q[11:8] <= q[11:8] + 1;
            end
        end
    end
	
endmodule
