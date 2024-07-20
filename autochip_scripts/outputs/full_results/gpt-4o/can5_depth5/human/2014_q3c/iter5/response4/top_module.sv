module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y, // corrected register Y to hold 3-bit value
    output reg z
);

    reg [2:0] next_state;

    always @(*) begin
        case (y)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase
    end

    always @(posedge clk) begin
        Y <= next_state; // Save the entire 3-bit state into Y
    end

    always @(*) begin
        z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;
    end
endmodule
