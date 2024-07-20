module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] next_state;
reg [5:0] current_state;

always @(posedge w or posedge y) begin
    current_state <= y;
    case (y)
        6'b000001: next_state = 6'b000100;
        6'b000010: next_state = 6'b001000;
        6'b000100: next_state = 6'b010000;
        6'b001000: next_state = 6'b000001;
        6'b010000: next_state = 6'b100000;
        6'b100000: next_state = 6'b000100;
        default: next_state = 6'b000001;
    endcase
end

assign Y1 = (next_state[4] && !current_state[4]) || (next_state[2] && !current_state[2]);
assign Y3 = (next_state[2] && !current_state[2]);

endmodule
