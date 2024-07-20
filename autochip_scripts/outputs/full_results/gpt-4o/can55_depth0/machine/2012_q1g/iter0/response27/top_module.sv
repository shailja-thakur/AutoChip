module top_module (
    input [4:0] x,
    output reg f
);
    always @(*) begin
        case (x)
            5'h00: f = 1;
            5'h01: f = 1;
            5'h02: f = 0;
            5'h03: f = 0;
            5'h04: f = 1;
            5'h05: f = 1;
            5'h06: f = 1;
            5'h07: f = 0;
            5'h08: f = 0;
            5'h09: f = 0;
            5'h0A: f = 0;
            5'h0B: f = 0;
            5'h0C: f = 1;
            5'h0D: f = 0;
            5'h0E: f = 1;
            5'h0F: f = 1;
            default: f = 0; // Default case to handle values beyond 0xF
        endcase
    end
endmodule
