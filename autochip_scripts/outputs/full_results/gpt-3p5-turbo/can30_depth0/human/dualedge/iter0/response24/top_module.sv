module top_module(
	input clk,
    input reset,
	input d,
	output reg q);
    
    reg q_1, q_2;
    
    always @(posedge clk or negedge reset) begin
        if (reset == 0) begin
            q_1 <= 0;
            q_2 <= 0;
        end else begin
            q_1 <= d;
            q_2 <= q_1;
        end
    end
    
    always @(posedge clk) begin
        q <= q_2;
    end
endmodule
