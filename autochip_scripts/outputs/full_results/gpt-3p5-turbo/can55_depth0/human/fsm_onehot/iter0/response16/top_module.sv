module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

reg [9:0] next_state;

always @(*)
begin
    case (state)
        10'b0000000001: next_state = 10'b0000000001;
        10'b0000000001: next_state = 10'b0000000010;
        10'b0000000010: next_state = 10'b0000000001;
        10'b0000000010: next_state = 10'b0000000011;
        10'b0000000011: next_state = 10'b0000000001;
        10'b0000000011: next_state = 10'b0000000100;
        10'b0000000100: next_state = 10'b0000000001;
        10'b0000000100: next_state = 10'b0000000101;
        10'b0000000101: next_state = 10'b0000001000;
        10'b0000000101: next_state = 10'b0000000110;
        10'b0000000110: next_state = 10'b0000001001;
        10'b0000000110: next_state = 10'b0000000111;
        10'b0000000111: next_state = 10'b0000000001;
        10'b0000000111: next_state = 10'b0000000111;
        10'b0000001000: next_state = 10'b0000000001;
        10'b0000001000: next_state = 10'b0000000010;
        10'b0000001001: next_state = 10'b0000000001;
        10'b0000001001: next_state = 10'b0000000010;
        default: next_state = 10'b0000000000;
    endcase
end

assign out1 = (state == 10'b0000000111) ? 1'b0 : 1'b0;
assign out2 = (state == 10'b0000001001) ? 1'b1 : 1'b0;

endmodule
