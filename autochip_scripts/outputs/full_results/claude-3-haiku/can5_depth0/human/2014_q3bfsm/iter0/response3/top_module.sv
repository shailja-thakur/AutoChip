module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y; // present state

always @(posedge clk) begin
    if (reset) begin
        y <= 3'b000; // reset to state 000
        z <= 1'b0;
    end
    else begin
        case (y)
            3'b000: begin
                y <= (x) ? 3'b001 : 3'b000;
                z <= 1'b0;
            end
            3'b001: begin
                y <= (x) ? 3'b100 : 3'b001;
                z <= 1'b0;
            end
            3'b010: begin
                y <= (x) ? 3'b001 : 3'b010;
                z <= 1'b0;
            end
            3'b011: begin
                y <= (x) ? 3'b010 : 3'b001;
                z <= 1'b1;
            end
            3'b100: begin
                y <= (x) ? 3'b100 : 3'b011;
                z <= 1'b1;
            end
            default: begin
                y <= 3'b000;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
