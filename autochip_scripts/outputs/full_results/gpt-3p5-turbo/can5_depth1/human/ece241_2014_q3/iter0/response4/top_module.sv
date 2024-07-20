module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Define internal signals
reg [1:0] ab;
reg [1:0] cd;

// Combine inputs c and d
assign cd = {c, d};

// Generate ab signals based on the cd values
always @*
begin
    case(cd)
        2'b00: ab = 2'b00;
        2'b01: ab = 2'b01;
        2'b11: ab = 2'b10;
        2'b10: ab = 2'b11;
    endcase
end

// Define the 4-to-1 multiplexer
assign mux_in[0] = (ab[1] & ab[0] & 1'b0) | (!ab[1] & ab[0] & 1'b1) | (!ab[1] & !ab[0] & 1'b1) | (ab[1] & !ab[0] & 1'b1);
assign mux_in[1] = (ab[1] & ab[0] & 1'b0) | (!ab[1] & ab[0] & 1'b0) | (!ab[1] & !ab[0] & 1'b0) | (ab[1] & !ab[0] & 1'b0);
assign mux_in[2] = (ab[1] & ab[0] & 1'b0) | (!ab[1] & ab[0] & 1'b0) | (!ab[1] & !ab[0] & 1'b1) | (ab[1] & !ab[0] & 1'b0);
assign mux_in[3] = (ab[1] & ab[0] & 1'b1) | (!ab[1] & ab[0] & 1'b1) | (!ab[1] & !ab[0] & 1'b1) | (ab[1] & !ab[0] & 1'b0);

endmodule
