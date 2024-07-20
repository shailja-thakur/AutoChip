module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

wire state_A, state_B, state_C, state_D;
assign state_A = state[0];
assign state_B = state[1];
assign state_C = state[2];
assign state_D = state[3];

always @(*) begin
    // Next state logic
    if (state_A) begin
        next_state = (in) ? 4'b0010 : 4'b0001; // A -> B, A
    end
    else if (state_B) begin
        next_state = (in) ? 4'b0010 : 4'b0100; // B -> B, C
    end
    else if (state_C) begin
        next_state = (in) ? 4'b1000 : 4'b0001; // C -> D, A
    end
    else if (state_D) begin
        next_state = (in) ? 4'b0010 : 4'b0100; // D -> B, C
    end
end

// Output logic
assign out = state_D & in;

endmodule
