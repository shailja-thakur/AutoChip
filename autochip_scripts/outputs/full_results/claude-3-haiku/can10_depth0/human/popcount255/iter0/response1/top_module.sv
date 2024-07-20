module top_module (
    input [254:0] in,
    output reg [7:0] out
);

reg [7:0] count [0:7];
integer i, j;

always @* begin
    // Initialize count registers
    for (i = 0; i < 8; i = i + 1)
        count[i] = 0;

    // Count the number of 1's in each 32-bit segment
    for (i = 0; i < 8; i = i + 1) begin
        for (j = 0; j < 32; j = j + 1) begin
            if (in[i*32 + j])
                count[i] = count[i] + 1;
        end
    end

    // Sum the counts from all 8 segments
    out = count[0] + count[1] + count[2] + count[3] + count[4] + count[5] + count[6] + count[7];
end

endmodule
