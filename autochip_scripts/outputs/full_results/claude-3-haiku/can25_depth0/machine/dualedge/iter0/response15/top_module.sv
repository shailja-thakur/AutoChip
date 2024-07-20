module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp, qn;

    // Update qp on positive clock edge
    always @(posedge clk) begin
        qp <= d;
    end

    // Update qn on negative clock edge
    always @(negedge clk) begin
        qn <= d;
    end

    // Assign q based on clock edge
    always @(clk) begin
        if (clk)
            q <= qp;
        else
            q <= qn;
    end

endmodule
