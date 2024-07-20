module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// Define internal wire and register signals
reg [2:0] Y;

always @(posedge clk) begin
    case ({y, x})
        3'b000_0 : begin
            Y <= 3'b000;
            z <= 1'b0;
        end
        3'b001_0 : begin
            Y <= 3'b001;
            z <= 1'b0;
        end
        3'b001_1 : begin
            Y <= 3'b100;
            z <= 1'b0;
        end
        3'b010_0 : begin
            Y <= 3'b010;
            z <= 1'b0;
        end
        3'b011_0 : begin
            Y <= 3'b001;
            z <= 1'b0;
        end
        3'b011_1 : begin
            Y <= 3'b010;
            z <= 1'b1;
        end
        3'b100_0 : begin
            Y <= 3'b011;
            z <= 1'b1;
        end
        default: begin
            Y <= 3'b000;
            z <= 1'b0;
        end
    endcase
end

// Assign output ports
assign Y0 = Y[0];

endmodule
