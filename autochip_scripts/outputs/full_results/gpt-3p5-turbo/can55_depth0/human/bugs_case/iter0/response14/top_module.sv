module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);
// Declare wires for comparing the input code with the recognized codes
wire [7:0] code_0 = 8'h45;
wire [7:0] code_1 = 8'h16;
wire [7:0] code_2 = 8'h1e;
wire [7:0] code_3 = 8'h26;
wire [7:0] code_4 = 8'h25;
wire [7:0] code_5 = 8'h2e;
wire [7:0] code_6 = 8'h36;
wire [7:0] code_7 = 8'h3d;
wire [7:0] code_8 = 8'h3e;
wire [7:0] code_9 = 8'h46;

// Compare the input code with the recognized codes using a case statement
always @(code) begin
    case (code)
        code_0: begin
            out <= 4'b0000;
            valid <= 1;
        end
        code_1: begin
            out <= 4'b0001;
            valid <= 1;
        end
        code_2: begin
            out <= 4'b0010;
            valid <= 1;
        end
        code_3: begin
            out <= 4'b0011;
            valid <= 1;
        end
        code_4: begin
            out <= 4'b0100;
            valid <= 1;
        end
        code_5: begin
            out <= 4'b0101;
            valid <= 1;
        end
        code_6: begin
            out <= 4'b0110;
            valid <= 1;
        end
        code_7: begin
            out <= 4'b0111;
            valid <= 1;
        end
        code_8: begin
            out <= 4'b1000;
            valid <= 1;
        end
        code_9: begin
            out <= 4'b1001;
            valid <= 1;
        end
        default: begin
            out <= 4'b0000;
            valid <= 0;
        end
    endcase
end

endmodule
