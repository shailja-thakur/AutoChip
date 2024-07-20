module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*) begin
        case (code)
            8'h45: begin out = 4'd0; valid = 1'b1; end // Key 0
            8'h16: begin out = 4'd1; valid = 1'b1; end // Key 1
            8'h1e: begin out = 4'd2; valid = 1'b1; end // Key 2
            8'h26: begin out = 4'd3; valid = 1'b1; end // Key 3
            8'h25: begin out = 4'd4; valid = 1'b1; end // Key 4
            8'h2e: begin out = 4'd5; valid = 1'b1; end // Key 5
            8'h36: begin out = 4'd6; valid = 1'b1; end // Key 6
            8'h3d: begin out = 4'd7; valid = 1'b1; end // Key 7
            8'h3e: begin out = 4'd8; valid = 1'b1; end // Key 8
            8'h46: begin out = 4'd9; valid = 1'b1; end // Key 9
            default: begin out = 4'd0; valid = 1'b0; end
        endcase
    end

endmodule
