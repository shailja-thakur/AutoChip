module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    case(sel)
        8'b0000_0000: out = in[3:0];
        8'b0000_0001: out = in[7:4];
        8'b0000_0010: out = in[11:8];
        8'b0000_0011: out = in[15:12];
        // Add the rest of the cases
        default: out = 4'bxxxx; // Handle all other sel values
    endcase
end

endmodule
