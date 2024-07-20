module top_module(
    input clk,
    input d,
    output reg q);

    reg qp, qn;

    // Update qp on the positive edge of the clock
    always @(posedge clk) begin
        qp <= d;
    end

    // Update qn on the negative edge of the clock
    always @(negedge clk) begin
        qn <= d;
    end

    // Assign q based on the value of clk
    always @(*) begin
        if (clk) begin
            q = qp;
        end else begin
            q = qn;
        end
    end
endmodule
