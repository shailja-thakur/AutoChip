module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always @(posedge clk) begin
        case({x,y})
            3'b000_000: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end

            3'b000_001: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end

            3'b000_100: begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end

            3'b001_001: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end

            3'b001_010: begin
                Y0 <= 1'b0;
                z <= 1'b1;
            end

            3'b001_011: begin
                Y0 <= 1'b0;
                z <= 1'b1;
            end

            3'b001_100: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end

            3'b010_010: begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end

            3'b010_011: begin
                Y0 <= 1'b1;
                z <= 1'b1;
            end

            3'b010_100: begin
                Y0 <= 1'b1;
                z <= 1'b1;
            end

            3'b011_000: begin
                Y0 <= 1'b0;
                z <= 1'b0;
            end

            3'b011_100: begin
                Y0 <= 1'b1;
                z <= 1'b0;
            end
        endcase
    end
endmodule
