module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg z
);
    always @(posedge clk) begin
        case(y)
            3'b000: begin
                if (x == 1'b0) Y <= 3'b000;
                else if (x == 1'b1) Y <= 3'b001;
                z <= 1'b0;
            end
            3'b001: begin
                if (x == 1'b0) Y <= 3'b001;
                else if (x == 1'b1) Y <= 3'b100;
                z <= 1'b0;
            end
            3'b010: begin
                if (x == 1'b0) Y <= 3'b010;
                else if (x == 1'b1) Y <= 3'b001;
                z <= 1'b0;
            end
            3'b011: begin
                if (x == 1'b0) Y <= 3'b001;
                else if (x == 1'b1) Y <= 3'b010;
                z <= 1'b1;
            end
            3'b100: begin
                if (x == 1'b0) Y <= 3'b011;
                else if (x == 1'b1) Y <= 3'b100;
                z <= 1'b1;
            end
            default: begin
                Y <= 3'b000;
                z <= 1'b0;
            end
        endcase
    end

    assign Y0 = Y[0];
endmodule
