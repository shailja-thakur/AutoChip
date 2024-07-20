module top_module (
    input [7:0] in,
    output parity
);

// signal declaration
reg bit_parity;

// assign the parity bit
assign parity = bit_parity;

// count number of 1s in the input using a for loop
integer i;
always @* begin
    bit_parity = in[0];
    for (i = 1; i < 8; i = i + 1) begin
        bit_parity = bit_parity ^ in[i];
    end
end

endmodule
