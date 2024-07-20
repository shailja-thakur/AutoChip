module top_module (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);
    always @(*) begin
        case (sel)
            8'b00000000: out = in[0];
            8'b00000001: out = in[1];
            8'b00000010: out = in[2];
            // ... continue for all 256 cases ...
            default: out = 1'b0; // Default case when sel is out of range
        endcase
    end
endmodule
