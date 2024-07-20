module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] sum; // additional bit for overflow detection

// perform addition
always @(*) begin
    sum = a + b;
end

// check for overflow
assign overflow = (sum[8] == 1);

// assign output
assign s = sum[7:0];

endmodule
