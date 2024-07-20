module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    // Define state parameters
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] Y;

    always @(posedge clk) begin
        case (y)
            S0: begin
                if (x == 1'b0)
                    Y = S0;
                else
                    Y = S1;
                z = 1'b0;
            end
            S1: begin
                if (x == 1'b0)
                    Y = S1;
                else
                    Y = S4;
                z = 1'b0;
            end
            S2: begin
                if (x == 1'b0)
                    Y = S2;
                else
                    Y = S1;
                z = 1'b0;
            end
            S3: begin
                if (x == 1'b0)
                    Y = S1;
                else
                    Y = S2;
                z = 1'b1;
            end
            S4: begin
                if (x == 1'b0)
                    Y = S3;
                else
                    Y = S4;
                z = 1'b1;
            end
        endcase
    end

    always @(*) begin
        Y0 = Y[0];
    end

endmodule
