module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] Y; // Internal 3-bit register to hold the next state
    
    always @(posedge clk) begin
        case (y)
            3'b000: begin
                Y = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                Y = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                Y = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                Y = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                Y = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                Y = 3'b000;
                z = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        Y0 <= Y[0]; // Assign the lower bit of Y to Y0 on every clock
    end

endmodule
