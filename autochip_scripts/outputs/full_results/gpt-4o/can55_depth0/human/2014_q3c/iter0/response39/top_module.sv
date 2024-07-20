module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    // Define next state variables
    reg [2:0] Y;

    // Combinational logic to determine next state based on current state and input x
    always @(*) begin
        case (y)
            3'b000: Y = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: Y = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: Y = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: Y = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: Y = (x == 1'b0) ? 3'b011 : 3'b100;
            default: Y = 3'b000;
        endcase
    end

    // Combinational logic for output z based on current state
    always @(*) begin
        case (y)
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // Sequential logic to update state on clock edge
    always @(posedge clk) begin
        Y0 <= Y[0];
    end

endmodule
