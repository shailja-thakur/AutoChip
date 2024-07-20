module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

reg [63:0] temp; // temporary register for shifting

always @(posedge clk) begin
    if (load) begin
        q <= data; // load the shift register with data when load is active
    end else begin
        case (amount)
            2'b00: temp <= q << 1; // shift left by 1 bit
            2'b01: temp <= q << 8; // shift left by 8 bits
            2'b10: temp <= q >> 1; // shift right by 1 bit (arithmetic)
            2'b11: temp <= q >> 8; // shift right by 8 bits (arithmetic)
            default: temp <= q; // no shift
        endcase
        if (ena) begin
            q <= temp; // update the shift register with shifted value when ena is active
        end
    end
end

endmodule
