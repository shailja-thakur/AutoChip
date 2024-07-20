module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001; // state A
        4'b0010: next_state = in ? 4'b0010 : 4'b0100; // state B
        4'b0100: next_state = in ? 4'b1000 : 4'b0001; // state C
        4'b1000: next_state = in ? 4'b0010 : 4'b0100; // state D
        default: next_state = 4'b0001; // default to state A
    endcase
end

assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // output logic

endmodule
