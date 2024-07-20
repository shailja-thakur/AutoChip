module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp; // Register to hold data when clk is positive
    reg qn; // Register to hold data when clk is negative

    always @(posedge clk) begin
        qp <= d; // Update qp with the value of d on positive edge of clk
    end

    always @(negedge clk) begin
        qn <= d; // Update qn with the value of d on negative edge of clk
    end

    always @(*) begin
        if (clk) begin
            q = qp; // Assign q the value of qp when clk is positive
        end else begin
            q = qn; // Assign q the value of qn when clk is negative
        end
    end

endmodule
