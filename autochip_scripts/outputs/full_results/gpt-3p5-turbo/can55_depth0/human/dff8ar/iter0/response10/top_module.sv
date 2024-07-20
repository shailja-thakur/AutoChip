module top_module (
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

// Define 8 D flip-flops
reg [7:0] q_reg [0:7];

// Assign the initial value of q_reg to 0
assign q = q_reg[7:0];

// Create the D flip-flops
always @(posedge clk or posedge areset) begin
    if (areset) begin
        q_reg <= 8'b0;
    end else begin
        q_reg <= d;
    end
end

endmodule
