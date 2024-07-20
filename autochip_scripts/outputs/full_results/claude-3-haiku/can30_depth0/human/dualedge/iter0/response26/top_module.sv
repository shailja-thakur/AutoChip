module top_module(
    input clk,
    input d,
    output reg q
);

    reg temp_q;

    always @(posedge clk) begin
        q <= d;
    end

    always @(negedge clk) begin
        temp_q <= d;
    end

    always @(posedge clk or negedge clk) begin
        q <= (q & !temp_q) | (!q & temp_q);
    end

endmodule
