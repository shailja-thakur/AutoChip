module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    if (in == 4'b0000)   // If none of the input bits are high
        pos = 2'b00;     // Output zero
    else if (in[3] == 1) // Check the highest bit first
        pos = 2'b11;
    else if (in[2] == 1)
        pos = 2'b10;
    else if (in[1] == 1)
        pos = 2'b01;
    else
        pos = 2'b00;     // Default case
end

endmodule
