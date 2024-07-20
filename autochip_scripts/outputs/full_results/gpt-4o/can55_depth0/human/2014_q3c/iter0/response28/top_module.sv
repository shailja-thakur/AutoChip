module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] Y; // Register to hold the next state value

    // Combinatorial logic to determine the next state and output z
    always @(*) begin
        case (y)
            3'b000: begin
                if (x == 0) Y = 3'b000;
                else Y = 3'b001;
                z = 0;
            end
            3'b001: begin
                if (x == 0) Y = 3'b001;
                else Y = 3'b100;
                z = 0;
            end
            3'b010: begin
                if (x == 0) Y = 3'b010;
                else Y = 3'b001;
                z = 0;
            end
            3'b011: begin
                if (x == 0) Y = 3'b001;
                else Y = 3'b010;
                z = 1;
            end
            3'b100: begin
                if (x == 0) Y = 3'b011;
                else Y = 3'b100;
                z = 1;
            end
            default: begin
                Y = 3'b000;
                z = 0;
            end
        endcase
    end

    // Sequential logic to update the state on the clock edge
    always @(posedge clk) begin
        Y0 <= Y[0];
    end

endmodule
