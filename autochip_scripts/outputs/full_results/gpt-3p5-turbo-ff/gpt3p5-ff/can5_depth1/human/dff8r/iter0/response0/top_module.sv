module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

    reg [7:0] q_temp;

    always @(posedge clk) begin
        if (reset) begin
            q_temp <= 8'b0;
        end else begin
            q_temp <= d;
        end
    end

    always @(posedge clk) begin
        q <= q_temp;
    end

endmodule
