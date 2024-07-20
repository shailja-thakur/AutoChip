module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] Y;

    always @(posedge clk) begin
        case (y)
            3'b000: Y <= (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: Y <= (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: Y <= (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: Y <= (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: Y <= (x == 1'b0) ? 3'b011 : 3'b100;
            default: Y <= 3'b000; // Default case to handle unexpected states
        endcase

        // Assign the next state Y to the output Y0
        Y0 <= Y[0];

        // Determine the output z based on the present state y
        case (y)
            3'b011, 3'b100: z <= 1'b1;
            default: z <= 1'b0;
        endcase
    end

endmodule
