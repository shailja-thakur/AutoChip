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
            3'b000: next_state <= (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state <= (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state <= (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state <= (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state <= (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state <= 3'b000;
        endcase
        Y0 <= next_state[0];
    end

    always @(*) begin
        z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;
    end

endmodule
