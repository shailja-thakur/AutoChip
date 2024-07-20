module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;
wire [2:0] state_wire;

assign state_wire = state;
assign z = state[2];

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @*
begin
    case (state_wire)
        3'b000: if (w) next_state = 3'b010; else next_state = 3'b000;
        3'b001: if (w) next_state = 3'b100; else next_state = 3'b001;
        3'b010: if (w) next_state = 3'b101; else next_state = 3'b100;
        3'b011: if (w) next_state = 3'b011; else next_state = 3'b100;
        3'b100: if (w) next_state = 3'b101; else next_state = 3'b011;
        3'b101: if (w) next_state = 3'b101; else next_state = 3'b100;
        3'b110: if (w) next_state = 3'b110; else next_state = 3'b011;
        3'b111: if (w) next_state = 3'b010; else next_state = 3'b011;
    endcase
end

endmodule
