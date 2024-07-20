module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*)
    begin
        case (code)
            8'h45: begin  // 0 detected
                out = 4'b0000;
                valid = 1;
            end
            8'h16: begin  // 1 detected
                out = 4'b0001;
                valid = 1;
            end
            8'h1e: begin  // 2 detected
                out = 4'b0010;
                valid = 1;
            end
            8'h26: begin  // 3 detected
                out = 4'b0011;
                valid = 1;
            end
            8'h25: begin  // 4 detected
                out = 4'b0100;
                valid = 1;
            end
            8'h2e: begin  // 5 detected
                out = 4'b0101;
                valid = 1;
            end
            8'h36: begin  // 6 detected
                out = 4'b0110;
                valid = 1;
            end
            8'h3d: begin  // 7 detected
                out = 4'b0111;
                valid = 1;
            end
            8'h3e: begin  // 8 detected
                out = 4'b1000;
                valid = 1;
            end
            8'h46: begin  // 9 detected
                out = 4'b1001;
                valid = 1;
            end
            default: begin  // No match
                out = 4'b0000;
                valid = 0;
            end
        endcase
    end
    
endmodule
