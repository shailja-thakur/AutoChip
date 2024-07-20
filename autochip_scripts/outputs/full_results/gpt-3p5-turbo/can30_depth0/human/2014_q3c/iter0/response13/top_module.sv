module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

reg [2:0] Y;

// Assigning the next state based on present state and input x
always @(posedge clk) begin
    case (y)
        3'b000:
            if (x == 0) begin
                Y <= 3'b000;
                z <= 0;
            end else begin
                Y <= 3'b001;
                z <= 0;
            end
        3'b001:
            if (x == 0) begin
                Y <= 3'b001;
                z <= 0;
            end else begin
                Y <= 3'b100;
                z <= 0;
            end
        3'b010:
            if (x == 0) begin
                Y <= 3'b010;
                z <= 0;
            end else begin
                Y <= 3'b001;
                z <= 0;
            end
        3'b011:
            if (x == 0) begin
                Y <= 3'b001;
                z <= 1;
            end else begin
                Y <= 3'b010;
                z <= 1;
            end
        3'b100:
            if (x == 0) begin
                Y <= 3'b011;
                z <= 1;
            end else begin
                Y <= 3'b100;
                z <= 1;
            end
    endcase
end

// Assigning the output signals based on the current state
always @(posedge clk) begin
    case (y)
        3'b000, 3'b001, 3'b010:
            Y0 <= 1'b0;
        3'b011, 3'b100:
            Y0 <= 1'b1;
    endcase
end

endmodule
