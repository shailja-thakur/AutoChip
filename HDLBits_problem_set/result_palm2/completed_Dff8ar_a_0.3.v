module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] d_reg;
    reg [7:0] q_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            d_reg <= 8'h0;
            q_reg <= 8'h0;
        end else begin
            d_reg <= d;
            q_reg <= d_reg;
        end
    end

    assign q = q_reg;

endmodule