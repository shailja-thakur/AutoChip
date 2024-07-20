module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

// Declare internal wire
wire [3:0] in_inv;

// Invert the input bits
assign in_inv = ~in;

// Find the position of the first 1 bit
always @ (in_inv) begin
    if (in_inv[0]) pos = 0;
    else if (in_inv[1]) pos = 1;
    else if (in_inv[2]) pos = 2;
    else if (in_inv[3]) pos = 3;
    else pos = 0;
end

endmodule
