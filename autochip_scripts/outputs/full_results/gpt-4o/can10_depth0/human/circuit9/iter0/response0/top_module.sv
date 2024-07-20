module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 3'd4;
        end else begin
            if (q == 3'd0)
                q <= 3'd1;
            else if (q == 3'd1)
                q <= 3'd2;
            else if (q == 3'd2)
                q <= 3'd3;
            else if (q == 3'd3)
                q <= 3'd4;
            else if (q == 3'd4)
                q <= 3'd5;
            else if (q == 3'd5)
                q <= 3'd6;
            else if (q == 3'd6)
                q <= 3'd0;
        end
    end

endmodule
