module top_module(
    input clk,
    input d,
    output reg q);

    reg q0, q1;

    always @ (posedge clk) begin
        q0 <= d;
    end

    always @ (negedge clk) begin
        q1 <= q0;
    end

    always @ (*) begin
        q <= q1;
    end

endmodule
