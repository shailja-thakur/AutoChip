module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'b000:
            next_state = (x) ? 3'b001 : 3'b000;
        3'b001:
            next_state = (x) ? 3'b100 : 3'b010;
        3'b010:
            next_state = (x) ? 3'b010 : 3'b011;
        3'b011:
            next_state = (x) ? 3'b100 : 3'b100;
        3'b100:
            next_state = (x) ? 3'b010 : 3'b101;
        default:
            next_state = (x) ? 3'b101 : 3'b011;
    endcase
end

always @(posedge clk) begin
    case (state)
        3'b000:
            z <= 1'b0;
        3'b001:
            z <= 1'b0;
        3'b010:
            z <= 1'b0;
        3'b011:
            z <= 1'b0;
        3'b100:
            z <= 1'b1;
        default:
            z <= 1'b1;
    endcase
end

endmodule
