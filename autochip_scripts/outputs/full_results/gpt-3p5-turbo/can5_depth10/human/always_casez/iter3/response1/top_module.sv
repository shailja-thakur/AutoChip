module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    pos = 0;
    // Iterate through each bit of the input vector
    for (int i = 0; i < 8; i=i+1) begin
        // Check if the current bit is high
        if (in[i] == 1'b1) begin
            // Assign the position of the high bit to 'pos'
            pos = i + 1;
            // Exit the loop
            break;
        end
    end
end

endmodule
