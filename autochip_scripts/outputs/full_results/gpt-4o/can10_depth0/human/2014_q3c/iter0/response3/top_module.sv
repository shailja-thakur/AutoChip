module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] Y;

    always @ (posedge clk) begin
        case (y)
            3'b000: begin 
                Y = (x == 0) ? 3'b000 : 3'b001; 
                z = 0;
            end
            3'b001: begin
                Y = (x == 0) ? 3'b001 : 3'b100; 
                z = 0;
            end
            3'b010: begin
                Y = (x == 0) ? 3'b010 : 3'b001;
                z = 0;
            end
            3'b011: begin
                Y = (x == 0) ? 3'b001 : 3'b010; 
                z = 1;
            end
            3'b100: begin
                Y = (x == 0) ? 3'b011 : 3'b100;
                z = 1;
            end
            default: begin
                Y = 3'b000;
                z = 0;
            end
        endcase
    end

    // Assign the output Y0 to the 0th bit of the next state Y
    always @ (posedge clk) begin
        Y0 <= Y[0];
    end

endmodule
