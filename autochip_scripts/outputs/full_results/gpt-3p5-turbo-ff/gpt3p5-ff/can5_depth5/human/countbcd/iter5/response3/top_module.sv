module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 3'b0;
        end else begin
            if (q[3:0] == 9) begin
                q[3:0] <= 0;
                ena[1] <= 1;
            end else if (q[7:4] == 9) begin
                q[7:4] <= 0;
                ena[2] <= 1;
            end else if (q[11:8] == 9) begin
                q[11:8] <= 0;
                ena[3] <= 1;
            end
            
            if (ena[1]) begin
                ena[1] <= 0;
                ena[2] <= 1;
            end else if (ena[2]) begin
                ena[2] <= 0;
                ena[3] <= 1;
            end else if (ena[3]) begin
                ena[3] <= 0;
            end else begin
                q <= q + 1;
            end
        end
    end
	
endmodule
