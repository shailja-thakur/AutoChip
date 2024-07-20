module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*) begin
        case (code)
            8'h45: begin
                out = 4'b0000;  // Recognized key 0
                valid = 1;
            end
            8'h16: begin
                out = 4'b0001;  // Recognized key 1
                valid = 1;
            end
            8'h1e: begin
                out = 4'b0010;  // Recognized key 2
                valid = 1;
            end
            8'h26: begin
                out = 4'b0011;  // Recognized key 3
                valid = 1;
            end
            8'h25: begin
                out = 4'b0100;  // Recognized key 4
                valid = 1;
            end
            8'h2e: begin
                out = 4'b0101;  // Recognized key 5
                valid = 1;
            end
            8'h36: begin
                out = 4'b0110;  // Recognized key 6
                valid = 1;
            end
            8'h3d: begin
                out = 4'b0111;  // Recognized key 7
                valid = 1;
            end
            8'h3e: begin
                out = 4'b1000;  // Recognized key 8
                valid = 1;
            end
            8'h46: begin
                out = 4'b1001;  // Recognized key 9
                valid = 1;
            end
            default: begin
                out = 4'b0000;
                valid = 0;
            end
        endcase
    end

endmodule
