module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 8'b0; // reset all flip-flops to 0
    end else begin
        q <= d; // on clock edge, assign input d to output q
    end
end

endmodule
