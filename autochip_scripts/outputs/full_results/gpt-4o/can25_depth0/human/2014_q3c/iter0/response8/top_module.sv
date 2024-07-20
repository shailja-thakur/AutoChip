module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] next_state;

    always @(*) begin
        case (y)
            3'b000: next_state = (x == 0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase

        // Assign Y0 from the next state
        Y0 = next_state[0];

        // Determine the output z based on the present state y
        case (y)
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
    end

    always @(posedge clk) begin
        y <= next_state;
    end

endmodule
