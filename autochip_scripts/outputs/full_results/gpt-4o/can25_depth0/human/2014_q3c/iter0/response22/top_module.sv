module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z);

    // Internal wire to hold the next state
    reg [2:0] Y;

    always @(*) begin
        case(y)
            3'b000:
                if (x == 0) begin
                    Y = 3'b000;
                    z = 0;
                end else begin
                    Y = 3'b001;
                    z = 0;
                end
            3'b001:
                if (x == 0) begin
                    Y = 3'b001;
                    z = 0;
                end else begin
                    Y = 3'b100;
                    z = 0;
                end
            3'b010:
                if (x == 0) begin
                    Y = 3'b010;
                    z = 0;
                end else begin
                    Y = 3'b001;
                    z = 0;
                end
            3'b011:
                if (x == 0) begin
                    Y = 3'b001;
                    z = 1;
                end else begin
                    Y = 3'b010;
                    z = 1;
                end
            3'b100:
                if (x == 0) begin
                    Y = 3'b011;
                    z = 1;
                end else begin
                    Y = 3'b100;
                    z = 1;
                end
            default: begin
                Y = 3'b000;
                z = 0;
            end
        endcase
    end

    always @(posedge clk) begin
        Y0 <= Y[0];
    end

endmodule
