module top_module(
    input clk,
    input d,
    output reg q);

    reg qp;
    reg qn;

    always @(posedge clk or negedge clk) begin
        if (posedge clk) begin
            qp <= d;
            q <= qp;  // Assign q with qp on positive edge
        end
        else begin
            qn <= d;
            q <= qn;  // Assign q with qn on negative edge
        end
    end

endmodule
