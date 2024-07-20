module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire [2:0] next_state;

assign z = (state == 3'b100) | (state == 3'b101);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        case ({w, state})
            2'b00: next_state = 3'b000;
            2'b01: next_state = 3'b010;
            2'b10: next_state = 3'b011;
            2'b11: next_state = 3'b100;
            default: next_state = 3'b000;
        endcase
        state <= next_state;
    end
end

endmodule
