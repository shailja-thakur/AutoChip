module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp; // Positive edge-triggered register
    reg qn; // Negative edge-triggered register

    always @(posedge clk) begin
        qp <= d; // Update qp on positive edge of clk
    end

    always @(negedge clk) begin
        qn <= d; // Update qn on negative edge of clk
    end

    always @(*) begin
        if (clk) // If clk is high
            q <= qp; // Assign qp to q
        else // If clk is low
            q <= qn; // Assign qn to q
    end

endmodule
