module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg z
);

    always @(posedge clk) begin
        case (y)
            3'b000: begin
                z = 0;
                if (x == 0)
                    Y = 3'b000;
                else
                    Y = 3'b001;
            end
            3'b001: begin
                z = 0;
                if (x == 0)
                    Y = 3'b001;
                else
                    Y = 3'b100;
            end
            3'b010: begin
                z = 0;
                if (x == 0)
                    Y = 3'b010;
                else
                    Y = 3'b001;
            end
            3'b011: begin
                z = 1;
                if (x == 0)
                    Y = 3'b001;
                else
                    Y = 3'b010;
            end
            3'b100: begin
                z = 1;
                if (x == 0)
                    Y = 3'b011;
                else
                    Y = 3'b100;
            end
            default: begin
                Y = 3'b000;
                z = 0;
            end
        endcase
    end
endmodule
