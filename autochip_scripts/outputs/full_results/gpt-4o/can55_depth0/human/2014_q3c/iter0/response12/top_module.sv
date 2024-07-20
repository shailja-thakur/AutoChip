module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,  // Define Y as a register to hold the next state
    output reg Y0,
    output reg z
);

always @(posedge clk) begin
    case (y)
        3'b000: begin
            if (x == 0)
                Y <= 3'b000;
            else
                Y <= 3'b001;
            z <= 0;
        end
        3'b001: begin
            if (x == 0)
                Y <= 3'b001;
            else
                Y <= 3'b100;
            z <= 0;
        end
        3'b010: begin
            if (x == 0)
                Y <= 3'b010;
            else
                Y <= 3'b001;
            z <= 0;
        end
        3'b011: begin
            if (x == 0)
                Y <= 3'b001;
            else
                Y <= 3'b010;
            z <= 1;
        end
        3'b100: begin
            if (x == 0)
                Y <= 3'b011;
            else
                Y <= 3'b100;
            z <= 1;
        end
        default: begin
            Y <= 3'b000; // Default reset scenario for safety
            z <= 0;
        end
    endcase
    Y0 <= Y[0]; // Assign Y0 as the least significant bit of Y
end

endmodule
