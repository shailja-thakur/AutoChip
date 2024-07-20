module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    integer i; // Declare an integer for the loop counter
    always_comb begin
        out = 0; // Initialize out to 0
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // Increment out by the value of the corresponding bit in "in"
        end
    end
endmodule
