module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
    case(y)
        3'b000:
            if (x == 0) begin
                Y <= 3'b000;
            end else begin
                Y <= 3'b001;
            end
        3'b001:
            if (x == 0) begin
                Y <= 3'b001;
            end else begin
                Y <= 3'b100;
            end
        3'b010:
            if (x == 0) begin
                Y <= 3'b010;
            end else begin
                Y <= 3'b001;
            end
        3'b011:
            if (x == 0) begin
                Y <= 3'b001;
            end else begin
                Y <= 3'b010;
            end
        3'b100:
            if (x == 0) begin
                Y <= 3'b011;
            end else begin
                Y <= 3'b100;
            end
    endcase
    
    Y0 <= Y[0];
    z <= (Y == 3'b011 || Y == 3'b100);
end

endmodule
