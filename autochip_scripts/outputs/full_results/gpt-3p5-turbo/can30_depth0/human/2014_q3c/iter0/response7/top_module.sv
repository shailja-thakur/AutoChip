module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case (y)
        3'b000: begin
            if (x == 1) begin
                Y <= 3'b001;
                z <= 1;
            end else begin
                Y <= 3'b000;
                z <= 0;
            end
        end
        3'b001: begin
            if (x == 1) begin
                Y <= 3'b100;
                z <= 0;
            end else begin
                Y <= 3'b001;
                z <= 0;
            end
        end
        3'b010: begin
            if (x == 1) begin
                Y <= 3'b001;
                z <= 0;
            end else begin
                Y <= 3'b010;
                z <= 0;
            end
        end
        3'b011: begin
            if (x == 1) begin
                Y <= 3'b010;
                z <= 1;
            end else begin
                Y <= 3'b001;
                z <= 0;
            end
        end
        3'b100: begin
            if (x == 1) begin
                Y <= 3'b100;
                z <= 1;
            end else begin
                Y <= 3'b011;
                z <= 1;
            end
        end
    endcase
    
    Y0 <= Y[0];
end

endmodule
