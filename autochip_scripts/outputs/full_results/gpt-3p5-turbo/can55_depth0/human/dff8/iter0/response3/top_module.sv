module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    reg [7:0] dff_reg [0:7];

    always @(posedge clk) begin
        for (integer i=0; i<8; i=i+1) begin
            dff_reg[i] <= d[i];
        end
    end

    always @* begin
        for (integer i=0; i<8; i=i+1) begin
            q[i] <= dff_reg[i];
        end
    end

endmodule
