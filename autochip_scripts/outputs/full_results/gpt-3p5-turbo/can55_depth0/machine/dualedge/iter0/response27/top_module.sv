module top_module(
    input wire clk,
    input wire d,
    output reg q);

    reg qp;
    reg qn;

    always @(posedge clk) begin
        qp <= d;
    end

    always @(negedge clk) begin
        qn <= d;
    end

    always @(clk) begin
        if (clk) begin
            q <= qp;
        end
        else begin
            q <= qn;
        end
    end

endmodule
