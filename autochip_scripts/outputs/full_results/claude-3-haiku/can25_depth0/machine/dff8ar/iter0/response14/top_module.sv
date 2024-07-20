module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 8'b0; // Assign 0 to the q output when areset is high
    end
    else begin
        q <= d; // Assign the d input to the q output when areset is low
    end
end

endmodule
