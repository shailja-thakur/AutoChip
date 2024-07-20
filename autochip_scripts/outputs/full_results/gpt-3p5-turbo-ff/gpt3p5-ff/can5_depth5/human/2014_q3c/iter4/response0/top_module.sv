module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case(y)
        3'b000:
            if (x == 0) begin
                Y <= 3'b000;
                Z <= 0;
            end else begin
                Y <= 3'b001;
                Z <= 0;
            end
        3'b001:
            if (x == 0) begin
                Y <= 3'b001;
                Z <= 0;
            end else begin
                Y <= 3'b100;
                Z <= 0;
            end
        3'b010:
            if (x == 0) begin
                Y <= 3'b010;
                Z <= 0;
            end else begin
                Y <= 3'b001;
                Z <= 0;
            end
        3'b011:
            if (x == 0) begin
                Y <= 3'b001;
                Z <= 0;
            end else begin
                Y <= 3'b010;
                Z <= 1;
            end
        3'b100:
            if (x == 0) begin
                Y <= 3'b011;
                Z <= 1;
            end else begin
                Y <= 3'b100;
                Z <= 1;
            end
    endcase
    
    Y0 <= Y[0];
    z <= Z;
end

endmodule
