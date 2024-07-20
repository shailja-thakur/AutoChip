module top_module(
	input clk,
	input d,
	output reg q);

    reg qp, qn;

    // Register qp updates with d on the positive edge of clk
    always @(posedge clk) begin
        qp <= d;
    end

    // Register qn updates with d on the negative edge of clk
    always @(negedge clk) begin
        qn <= d;
    end

    // Output q is assigned based on the value of clk
    always @(*) begin
        if (clk)
            q = qp;
        else
            q = qn;
    end

endmodule
