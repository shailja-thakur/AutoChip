module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;
    else begin
        case(state)
            2'b00: begin
                state <= x ? 2'b01 : 2'b00;
                z <= 1'b0;
            end
            2'b01: begin
                state <= x ? 2'b00 : 2'b01;
                z <= 1'b1;
            end
            default: state <= state;
        endcase
    end
end

endmodule
