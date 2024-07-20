module top_module(
    input clk,
    input d,
    output reg q);

    reg qp;
    reg qn;

    always @(posedge clk or negedge clk) begin
        if (clk) begin
            qp <= d;
        end
        else begin
            qn <= d;
        end

        if (clk) begin
            q <= qp;  // Assign q with qp on positive edge
        end
        else begin
            q <= qn;  // Assign q with qn on negative edge
        end
    end

endmodule
