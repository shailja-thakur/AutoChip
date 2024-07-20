module top_module (
    input [99:0] in,
    output reg [99:0] out
);

// Create a temporary wire to hold the reversed bits
wire [99:0] reversed;

// Reverse the input bits using a for loop
genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin
        assign reversed[i] = in[99 - i];
    end
endgenerate

// Assign the reversed bits to the output
always @(posedge in) begin
    out <= reversed;
end

endmodule
