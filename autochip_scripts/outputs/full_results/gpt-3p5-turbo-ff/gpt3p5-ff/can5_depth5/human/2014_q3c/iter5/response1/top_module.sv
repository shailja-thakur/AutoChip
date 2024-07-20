module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg [2:0] Y,
    output reg Y0,
    output reg z
);

// Create a separate always block for combinational logic
always @* begin
    case(y)
        3'b000:
            if (x == 0) begin
                Y = 3'b000;
                Y0 = Y[0];
                z = 0;
            end else begin
                Y = 3'b001;
                Y0 = Y[0];
                z = 0;
            end
        3'b001:
            if (x == 0) begin
                Y = 3'b001;
                Y0 = Y[0];
                z = 0;
            end else begin
                Y = 3'b100;
                Y0 = Y[0];
                z = 0;
            end
        3'b010:
            if (x == 0) begin
                Y = 3'b010;
                Y0 = Y[0];
                z = 0;
            end else begin
                Y = 3'b001;
                Y0 = Y[0];
                z = 0;
            end
        3'b011:
            if (x == 0) begin
                Y = 3'b001;
                Y0 = Y[0];
                z = 0;
            end else begin
                Y = 3'b010;
                Y0 = Y[0];
                z = 1;
            end
        3'b100:
            if (x == 0) begin
                Y = 3'b011;
                Y0 = Y[0];
                z = 1;
            end else begin
                Y = 3'b100;
                Y0 = Y[0];
                z = 1;
            end
    endcase
end

endmodule
