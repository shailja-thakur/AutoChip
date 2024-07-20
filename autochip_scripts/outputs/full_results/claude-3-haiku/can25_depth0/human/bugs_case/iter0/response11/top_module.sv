module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

always @(*) begin
    valid = 1'b0;
    out = 4'b0000;
    case (code)
        8'h45: begin
            valid = 1'b1;
            out = 4'd0;
        end
        8'h16: begin
            valid = 1'b1;
            out = 4'd1;
        end
        8'h1e: begin
            valid = 1'b1;
            out = 4'd2;
        end
        8'h26: begin
            valid = 1'b1;
            out = 4'd3;
        end
        8'h25: begin
            valid = 1'b1;
            out = 4'd4;
        end
        8'h2e: begin
            valid = 1'b1;
            out = 4'd5;
        end
        8'h36: begin
            valid = 1'b1;
            out = 4'd6;
        end
        8'h3d: begin
            valid = 1'b1;
            out = 4'd7;
        end
        8'h3e: begin
            valid = 1'b1;
            out = 4'd8;
        end
        8'h46: begin
            valid = 1'b1;
            out = 4'd9;
        end
        default: begin
            valid = 1'b0;
            out = 4'b0000;
        end
    endcase
end

endmodule
