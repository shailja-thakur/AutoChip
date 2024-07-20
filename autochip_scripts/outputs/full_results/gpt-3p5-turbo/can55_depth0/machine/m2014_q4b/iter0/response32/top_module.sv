module top_module (
    input logic clk,
    input logic d,
    input logic ar,
    output logic q
);

reg q_reg;

always @(posedge clk or posedge ar)
    if (ar)
        q_reg <= 0;
    else if (clk)
        q_reg <= d;

assign q = q_reg;

endmodule
