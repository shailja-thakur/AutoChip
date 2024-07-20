module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    integer i;  // Declare an integer for the loop counter

    always_comb begin
        out = 0;  // Initialize output to 0
        for(i = 0; i < 255; i = i + 1) begin
            out = out + in[i];  // Increment output by the value of each bit in the input
        end
    end

endmodule
