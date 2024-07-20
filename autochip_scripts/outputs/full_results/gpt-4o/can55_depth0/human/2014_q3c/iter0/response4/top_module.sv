module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state;  // to keep track of present state

    always @(posedge clk) begin
        case (state)
            3'b000: begin
                state <= (x == 1'b0) ? 3'b000 : 3'b001;
                z <= 1'b0;
            end
            3'b001: begin
                state <= (x == 1'b0) ? 3'b001 : 3'b100;
                z <= 1'b0;
            end
            3'b010: begin
                state <= (x == 1'b0) ? 3'b010 : 3'b001;
                z <= 1'b0;
            end
            3'b011: begin
                state <= (x == 1'b0) ? 3'b001 : 3'b010;
                z <= 1'b1;
            end
            3'b100: begin
                state <= (x == 1'b0) ? 3'b011 : 3'b100;
                z <= 1'b1;
            end
            default: state <= 3'b000; // default state
        endcase
    end

    always @(state) begin
        case (state)
            3'b000: Y0 = 1'b0;
            3'b001: Y0 = 1'b1;
            3'b010: Y0 = 1'b0;
            3'b011: Y0 = 1'b1;
            3'b100: Y0 = 1'b0;
            default: Y0 = 1'b0;
        endcase
    end

endmodule
