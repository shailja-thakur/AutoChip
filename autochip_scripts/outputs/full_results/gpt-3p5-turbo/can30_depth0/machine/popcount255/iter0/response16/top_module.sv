module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Initialize output signal "out" to 0
always_comb begin
    out = 0;

    // Iterate through all the bits of the input signal "in"
    for (int i=0; i<255; i=i+1) begin
        // Increment the value of "out" by the value of the corresponding bit in the input signal
        out = out + in[i];
    end
end

endmodule
