module top_module(
	input clk,
	input d,
	output reg q);

    reg dq1, dq2;

    always @(posedge clk) begin
        dq1 <= d;
    end

    always @(negedge clk) begin
        dq2 <= d;
    end

    always @(posedge clk or negedge clk) begin
        if(clk)
            q <= dq1;
        else
            q <= dq2;
    end

endmodule
