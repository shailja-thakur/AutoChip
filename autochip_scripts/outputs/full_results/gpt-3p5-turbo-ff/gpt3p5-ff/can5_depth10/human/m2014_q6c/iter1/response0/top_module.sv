module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

reg [6:1] next_state;
wire [6:1] current_state;

// The current_state should be created based on y input

always @(*) begin
    case (y)
        7'b000001: current_state = 7'b000001;
        7'b000010: current_state = 7'b000010;
        7'b000100: current_state = 7'b000100;
        7'b001000: current_state = 7'b001000;
        7'b010000: current_state = 7'b010000;
        7'b100000: current_state = 7'b100000;
        default: current_state = 7'b000001;
    endcase
end

always @(current_state, w) begin
    case (current_state)
        7'b000001: next_state = (w) ? 7'b000010 : 7'b000001;
        7'b000010: next_state = (w) ? 7'b000100 : 7'b000001;
        7'b000100: next_state = (w) ? 7'b001000 : 7'b000001;
        7'b001000: next_state = (w) ? 7'b010000 : 7'b000001;
        7'b010000: next_state = (w) ? 7'b100000 : 7'b000001;
        7'b100000: next_state = (w) ? 7'b000001 : 7'b000001;
        default: next_state = 7'b000001;
    endcase
end

assign Y2 = next_state[2];
assign Y4 = next_state[4];

endmodule
