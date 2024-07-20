module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always @(posedge clk) begin
        case (y)
            3'b000: begin
                if (x)
                    Y0 = 1'b1; // y = 001
                else
                    Y0 = 1'b0; // y = 000
                z = 1'b0;
            end
            3'b001: begin
                if (x)
                    Y0 = 1'b0; // y = 100
                else
                    Y0 = 1'b1; // y = 001
                z = 1'b0;
            end
            3'b010: begin
                if (x)
                    Y0 = 1'b1; // y = 001
                else
                    Y0 = 1'b0; // y = 010
                z = 1'b0;
            end
            3'b011: begin
                if (x)
                    Y0 = 1'b0; // y = 010
                else
                    Y0 = 1'b1; // y = 001
                z = 1'b1;
            end
            3'b100: begin
                if (x)
                    Y0 = 1'b0; // y = 100
                else
                    Y0 = 1'b1; // y = 011
                z = 1'b1;
            end
            default: begin
                Y0 = 1'b0;
                z = 1'b0;
            end
        endcase
    end
endmodule
