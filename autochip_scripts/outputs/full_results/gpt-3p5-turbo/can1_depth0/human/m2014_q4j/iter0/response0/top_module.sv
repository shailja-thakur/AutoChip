module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// Define 4 full adders
wire [3:0] carry;
wire [3:0] sum_temp;
assign carry[0] = 1'b0;
assign carry[1] = x[0] & y[0];
assign sum_temp[0] = x[0] ^ y[0];

// Propagate carry and calculate sum for each bit
generate
    genvar i;
    for (i = 1; i < 4; i = i + 1) begin : gen_loop
        assign carry[i+1] = (x[i] & y[i]) | (carry[i] & (x[i] ^ y[i]));
        assign sum_temp[i] = x[i] ^ y[i] ^ carry[i];
    end
endgenerate

// Connect outputs
assign sum[0] = carry[4];
assign sum[1:4] = sum_temp;

endmodule
