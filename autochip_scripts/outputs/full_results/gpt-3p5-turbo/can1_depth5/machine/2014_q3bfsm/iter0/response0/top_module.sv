module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'b000:
            next_state = (x) ? 3'b001 : 3'b000;
        3'b001:
            next_state = (x) ? 3'b100 : 3'b001;
        3'b010:
            next_state = (x) ? 3'b001 : 3'b010;
        3'b011:
            next_state = (x) ? 3'b010 : 3'b011;
        3'b100:
            next_state = (x) ? 3'b011 : 3'b100;
        default:
            next_state = (x) ? 3'b100 : 3'b101;
    endcase
end

always @(state) begin
    z = (state == 3'b100 || state == 3'b101);
end

endmodule
