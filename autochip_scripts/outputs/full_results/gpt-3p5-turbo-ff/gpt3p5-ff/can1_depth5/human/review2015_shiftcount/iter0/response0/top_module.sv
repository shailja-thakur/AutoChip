module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
    
    always @(posedge clk) begin
        if(count_ena) begin
            if(q == 4'b0000) 
                q <= 4'b1111;
            else 
                q <= q - 4'b0001;
        end
        else if(shift_ena) begin
            q <= {q[2:0], data};
        end
        else begin
            q <= q;
        end
    end
endmodule
