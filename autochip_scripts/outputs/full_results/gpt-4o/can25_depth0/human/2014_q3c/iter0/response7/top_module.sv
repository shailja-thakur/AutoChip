module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] next_y;

    always @(*) begin
        // State transition logic
        case (y)
            3'b000: next_y = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_y = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_y = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_y = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_y = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_y = 3'b000;
        endcase
        
        // Output logic
        case (y)
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        Y0 <= next_y[0];
    end

endmodule
