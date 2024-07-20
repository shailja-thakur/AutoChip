module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);
// Register to hold the output
reg [3:0] q_reg;

always @(posedge clk or posedge areset) begin
    if (areset)
        q_reg <= 4'b0; // Reset the shift register to zero
    else if (load)
        q_reg <= data; // Load the shift register with data[3:0]
    else if (ena)
        q_reg <= {q_reg[2:0], 1'b0}; // Shift right (q[3] becomes zero, q[0] is shifted out and disappears)
end

// Assign the output to the register
assign q = q_reg;

endmodule
