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
            ena[1] <= (q[3:0] == 9) ? 1'b0 : 1'b1;
            ena[2] <= (q[7:4] == 9) ? 1'b0 : ena[1];
            ena[3] <= (q[11:8] == 9) ? 1'b0 : ena[2];
            
            if (ena[3]) begin
                q[11:8] <= q[11:8] + 1;
            end
            
            if (ena[2]) begin
                q[7:4] <= q[7:4] + 1;
            end
            
            if (ena[1]) begin
                q[3:0] <= q[3:0] + 1;
            end
        end
    end
	
endmodule
