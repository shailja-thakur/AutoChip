module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] q;
    reg [7:0] d_reg;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            q <= 0x34;
        end else begin
            q <= d_reg;
        end
    end

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            d_reg <= 0;
        end else begin
            d_reg <= d;
        end
    end

endmodule