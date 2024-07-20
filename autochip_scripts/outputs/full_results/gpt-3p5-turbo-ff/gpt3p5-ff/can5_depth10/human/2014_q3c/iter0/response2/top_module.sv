module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always @(posedge clk) begin
        case ({y, x})

            // State: 000, Next State (x=0): 000, Next State (x=1): 001, Output: 0
            7'b000_0 : begin
                Y0 <= 0;
                z <= 0;
            end
            7'b000_1 : begin
                Y0 <= 0;
                z <= 0;
            end

            // State: 001, Next State (x=0): 001, Next State (x=1): 100, Output: 0
            7'b001_0 : begin
                Y0 <= 0;
                z <= 0;
            end
            7'b001_1 : begin
                Y0 <= 0;
                z <= 0;
            end

            // State: 010, Next State (x=0): 010, Next State (x=1): 001, Output: 0
            7'b010_0 : begin
                Y0 <= 0;
                z <= 0;
            end
            7'b010_1 : begin
                Y0 <= 0;
                z <= 0;
            end

            // State: 011, Next State (x=0): 001, Next State (x=1): 010, Output: 1
            7'b011_0 : begin
                Y0 <= 0;
                z <= 1;
            end
            7'b011_1 : begin
                Y0 <= 0;
                z <= 1;
            end

            // State: 100, Next State (x=0): 011, Next State (x=1): 100, Output: 1
            7'b100_0 : begin
                Y0 <= 1;
                z <= 1;
            end
            7'b100_1 : begin
                Y0 <= 1;
                z <= 1;
            end

            default : begin
                Y0 <= 0;
                z <= 0;
            end

        endcase
    end
endmodule
