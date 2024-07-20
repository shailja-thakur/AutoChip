module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] next_state;

always @(posedge clk) begin
    case (y)
        3'b000: begin
            next_state = x ? 3'b001 : 3'b000;
            z = 1'b0;
        end
        3'b001: begin
            next_state = x ? 3'b100 : 3'b001;
            z = 1'b0;
        end
        3'b010: begin
            next_state = x ? 3'b001 : 3'b010;
            z = 1'b0;
        end
        3'b011: begin
            next_state = x ? 3'b010 : 3'b001;
            z = 1'b1;
        end
        3'b100: begin
            next_state = x ? 3'b100 : 3'b011;
            z = 1'b1;
        end
        default: begin
            next_state = 3'b000;
            z = 1'b0;
        end
    endcase

    Y0 = next_state[0];
end

endmodule
