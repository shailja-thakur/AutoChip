module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    
    always @(*) begin
        casez(in)
            4'b1???: pos = 2'b11; // Highest priority at position 3
            4'b01??: pos = 2'b10; // Next priority at position 2
            4'b001?: pos = 2'b01; // Next priority at position 1
            4'b0001: pos = 2'b00; // Lowest priority at position 0
            default: pos = 2'b00; // Default to 0 if none of the bits are high
        endcase
    end

endmodule
