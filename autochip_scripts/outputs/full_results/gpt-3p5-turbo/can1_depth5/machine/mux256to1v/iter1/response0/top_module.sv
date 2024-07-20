module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(sel)begin
    case(sel)
        8'b00000000: out = in[3:0];
        8'b00000001: out = in[7:4];
        8'b00000010: out = in[11:8];
        8'b00000011: out = in[15:12];
        // continue with the rest of the cases
        default: out = 4'bZZZZ; // handle all other sel values
    endcase
end

endmodule
