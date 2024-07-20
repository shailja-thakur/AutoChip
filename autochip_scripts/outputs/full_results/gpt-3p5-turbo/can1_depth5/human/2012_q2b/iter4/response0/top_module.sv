module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

reg [5:0] y_reg;

always @(posedge w) begin
    y_reg <= y;
end

always @(y_reg) begin
    case (y_reg)
        6'b010000: begin
            Y1 <= 1'b1; // Y1 is high when state is E
            Y3 <= 1'b0; // Y3 is low when state is E
        end
        6'b001000: begin
            Y1 <= 1'b0; // Y1 is low when state is D
            Y3 <= 1'b1; // Y3 is high when state is D
        end
        default: begin
            Y1 <= 1'b0; // Y1 is low for all other states
            Y3 <= 1'b0; // Y3 is low for all other states
        end
    endcase
end

endmodule
