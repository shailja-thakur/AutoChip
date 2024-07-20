module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    // D Flip-Flops for storing the state variables
    reg [2:0] Y;

    always @(posedge clk) begin
        if (x == 0) begin
            case(y)
                3'b000: Y <= 3'b000;
                3'b001: Y <= 3'b001;
                3'b010: Y <= 3'b010;
                3'b011: Y <= 3'b001;
                3'b100: Y <= 3'b011;
                default: Y <= 3'b000;
            endcase
        end else begin
            case(y)
                3'b000: Y <= 3'b001;
                3'b001: Y <= 3'b100;
                3'b010: Y <= 3'b001;
                3'b011: Y <= 3'b010;
                3'b100: Y <= 3'b100;
                default: Y <= 3'b000;
            endcase
        end
    end

    // Outputs
    assign Y0 = Y[0];
    assign z = (Y == 3'b011 || Y == 3'b100);

endmodule
