module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
    reg [3:0] q0, q1, q2, q3;
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q0 <= 0;
            q1 <= 0;
            q2 <= 0;
            q3 <= 0;
        end else begin
            q0 <= q0 + 1;
            if (q0 == 10) q0 <= 0;
            
            if (ena[1]) begin
                q1 <= q1 + 1;
                if (q1 == 10) q1 <= 0;
            end
            
            if (ena[2]) begin
                q2 <= q2 + 1;
                if (q2 == 10) q2 <= 0;
            end
            
            if (ena[3]) begin
                q3 <= q3 + 1;
                if (q3 == 10) q3 <= 0;
            end
        end
    end
    
    assign q = {q3, q2, q1, q0};
endmodule
