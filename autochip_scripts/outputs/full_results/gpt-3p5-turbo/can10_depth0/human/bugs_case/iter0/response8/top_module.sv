module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

always @(*)
begin
    case(code)
        8'h45: begin
            out = 4'b0000; // Key 0
            valid = 1;
        end
        8'h16: begin
            out = 4'b0001; // Key 1
            valid = 1;
        end
        8'h1e: begin
            out = 4'b0010; // Key 2
            valid = 1;
        end
        8'h26: begin
            out = 4'b0011; // Key 3
            valid = 1;
        end
        8'h25: begin
            out = 4'b0100; // Key 4
            valid = 1;
        end
        8'h2e: begin
            out = 4'b0101; // Key 5
            valid = 1;
        end
        8'h36: begin
            out = 4'b0110; // Key 6
            valid = 1;
        end
        8'h3d: begin
            out = 4'b0111; // Key 7
            valid = 1;
        end
        8'h3e: begin
            out = 4'b1000; // Key 8
            valid = 1;
        end
        8'h46: begin
            out = 4'b1001; // Key 9
            valid = 1;
        end
        default: begin
            out = 4'b0000; // No key recognized
            valid = 0;
        end
    endcase
end

endmodule
