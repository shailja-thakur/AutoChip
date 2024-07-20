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
            if (x == 0) begin
                Y <= 3'b000;
                z <= 1'b0;
            end else if (x == 1) begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        end
        3'b001: begin
            if (x == 0) begin
                Y <= 3'b001;
                z <= 1'b0;
            end else if (x == 1) begin
                Y <= 3'b100;
                z <= 1'b0;
            end
        end
        3'b010: begin
            if (x == 0) begin
                Y <= 3'b010;
                z <= 1'b0;
            end else if (x == 1) begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        end
        3'b011: begin
            if (x == 0) begin
                Y <= 3'b001;
                z <= 1'b010;
            end else if (x == 1) begin
                Y <= 3'b010;
                z <= 1'b1;
            end
        end
        3'b100: begin
            if (x == 0) begin
                Y <= 3'b011;
                z <= 1'b1;
            end else if (x == 1) begin
                Y <= 3'b100;
                z <= 1'b1;
            end
        end
    endcase
end

endmodule
