module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg z
);

always @(posedge clk) begin
    case(y)
        3'b000:
            if(x) begin
                Y <= 3'b001;
                z <= 1'b0;
            end else begin
                Y <= 3'b000;
                z <= 1'b0;
            end
        3'b001:
            if(x) begin
                Y <= 3'b100;
                z <= 1'b0;
            end else begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        3'b010:
            if(x) begin
                Y <= 3'b001;
                z <= 1'b0;
            end else begin
                Y <= 3'b010;
                z <= 1'b0;
            end
        3'b011:
            if(x) begin
                Y <= 3'b010;
                z <= 1'b1;
            end else begin
                Y <= 3'b001;
                z <= 1'b0;
            end
        3'b100:
            if(x) begin
                Y <= 3'b100;
                z <= 1'b1;
            end else begin
                Y <= 3'b011;
                z <= 1'b1;
            end
    endcase
end

endmodule
