module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] d_reg [7:0];
    reg [7:0] q_reg [7:0];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            d_reg <= 8'h0;
        end else begin
            d_reg <= d;
        end
        q_reg <= d_reg;
    end

    assign q = q_reg;

endmodule