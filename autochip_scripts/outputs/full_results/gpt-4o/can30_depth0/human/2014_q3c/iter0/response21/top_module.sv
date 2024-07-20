module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] Y; // Internal register for next state

    always @(*) begin
        case (y) // Combinational logic for next state and output
            3'b000: begin
                if (x)
                    Y = 3'b001;
                else
                    Y = 3'b000;
                z = 0;
            end
            3'b001: begin
                if (x)
                    Y = 3'b100;
                else
                    Y = 3'b001;
                z = 0;
            end
            3'b010: begin
                if (x)
                    Y = 3'b001;
                else
                    Y = 3'b010;
                z = 0;
            end
            3'b011: begin
                if (x)
                    Y = 3'b010;
                else
                    Y = 3'b001;
                z = 1;
            end
            3'b100: begin
                if (x)
                    Y = 3'b100;
                else
                    Y = 3'b011;
                z = 1;
            end
            default: begin
                Y = 3'b000;
                z = 0;
            end
        endcase
        Y0 = Y[0]; // Assign least significant bit of Y to output Y0
    end

    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
        end else begin
            y <= Y; // Update state with next state
        end
    end
endmodule
