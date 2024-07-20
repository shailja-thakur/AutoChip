module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// Declare internal signals
reg[2:0] Y;

// State assignments
always @(posedge clk) begin
    case(y)
        3'b000: Y <= x ? 3'b001 : 3'b000;
        3'b001: Y <= x ? 3'b100 : 3'b001;
        3'b010: Y <= x ? 3'b001 : 3'b010;
        3'b011: Y <= x ? 3'b010 : 3'b001;
        3'b100: Y <= x ? 3'b011 : 3'b100; // Fix state assignment for 3'b100
        default: Y <= 3'b000;
    endcase
end

// Output assignments
always @(posedge clk) begin
    case(y)
        3'b000: begin
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'b001: begin
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'b010: begin
            Y0 <= Y[0];
            z <= 1'b0;
        end
        3'b011: begin
            Y0 <= Y[0];
            z <= 1'b1;
        end
        3'b100: begin
            Y0 <= Y[0];
            z <= 1'b1;
        end
        default: begin
            Y0 <= 1'b0;
            z <= 1'b0;
        end
    endcase
end

endmodule
