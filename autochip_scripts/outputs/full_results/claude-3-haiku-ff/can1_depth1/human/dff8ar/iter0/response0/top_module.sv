module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 8'b0; // Reset output to 0 on active high asynchronous reset
    end
    else begin
        q <= d; // Assign input d to output q on positive edge of clk
    end
end

endmodule
