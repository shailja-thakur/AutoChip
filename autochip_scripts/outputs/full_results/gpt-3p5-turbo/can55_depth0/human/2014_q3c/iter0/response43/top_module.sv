module top_module (
    input clk,
    input x,
    input [2:0] y,
    output Y0,
    output z
);

reg [2:0] Y;

always @(posedge clk) begin

    case({x, y})
        2'b00: begin
            Y <= 3'b000;  // next state for x=0
            z <= 1'b0;
        end

        2'b01: begin
            Y <= 3'b100;  // next state for x=1
            z <= 1'b0;
        end

        2'b10: begin
            Y <= 3'b001;  // next state for x=0
            z <= 1'b0;
        end

        2'b11: begin
            Y <= 3'b010;  // next state for x=1
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
