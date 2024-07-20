module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    reg [8:0] temp_s; // Define an extra bit to check for overflow

    always @(*) begin
        temp_s = a + b;
        s = temp_s[7:0]; // Extract the result from the 8-bit sum
        overflow = temp_s[8]; // Check the overflow bit
    end
endmodule
