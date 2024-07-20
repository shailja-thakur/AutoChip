module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        Y <= 3'b000;
        z <= 1'b0;
    end else begin
        case ({y, x})
            3'b000: begin
                Y <= 3'b000;
                z <= 1'b0;
            end
            3'b001: begin
                Y <= x ? 3'b100 : 3'b001;
                z <= 1'b0;
            end
            3'b010: begin
                Y <= 3'b001;
                z <= 1'b0;
            end
            3'b011: begin
                Y <= x ? 3'b010 : 3'b001;
                z <= 1'b1;
            end
            3'b100: begin
                Y <= x ? 3'b011 : 3'b100; // corrected assignment
                z <= 1'b1;
            end
            default: begin
                Y <= 3'b000;
                z <= 1'b0;
            end
        endcase
    end
end

assign Y0 = Y[0];

endmodule
