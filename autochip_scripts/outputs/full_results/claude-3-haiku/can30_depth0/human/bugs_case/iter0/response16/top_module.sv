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
            out = 4'b0000;
        end
        8'h16: begin
            valid = 1'b1;
            out = 4'b0001;
        end
        8'h1e: begin
            valid = 1'b1;
            out = 4'b0010;
        end
        8'h26: begin
            valid = 1'b1;
            out = 4'b0011;
        end
        8'h25: begin
            valid = 1'b1;
            out = 4'b0100;
        end
        8'h2e: begin
            valid = 1'b1;
            out = 4'b0101;
        end
        8'h36: begin
            valid = 1'b1;
            out = 4'b0110;
        end
        8'h3d: begin
            valid = 1'b1;
            out = 4'b0111;
        end
        8'h3e: begin
            valid = 1'b1;
            out = 4'b1000;
        end
        8'h46: begin
            valid = 1'b1;
            out = 4'b1001;
        end
    endcase
end

endmodule
