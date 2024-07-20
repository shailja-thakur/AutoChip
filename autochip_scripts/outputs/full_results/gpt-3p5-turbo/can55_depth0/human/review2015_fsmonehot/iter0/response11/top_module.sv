module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

wire [9:0] next_state;
wire [2:0] output_logic;

// Implementing the state transition logic
assign next_state = state;

// B3_next -- next-state logic for state B3
assign B3_next = (state == 10'b0000000010) ? 1'b1
              : 1'b0;

// S_NEXT -- next-state logic for state S
assign S_next = (state == 10'b0000000001) ? 1'b1
              : (state == 10'b0000000010) ? 1'b1
              : 1'b0;

// S1_NEXT -- next-state logic for state S1
assign S1_next = (state == 10'b0000000010) ? 1'b1
               : (state == 10'b0000000100) ? 1'b1
               : 1'b0;

// Count_NEXT -- next-state logic for state Count
assign Count_next = (state == 10'b1000000000) ? 1'b1
                  : (state == 10'b1000000001 && done_counting) ? 1'b1
                  : 1'b0;

// Wait_NEXT -- next-state logic for state Wait
assign Wait_next = (state == 10'b1000000001 && !done_counting) ? 1'b1
                 : (state == 10'b1000000010 && !done) ? 1'b1
                 : 1'b0;

// Implementing the output logic
always @* begin
    case (state)
        10'b0000000001: output_logic = 3'b000; // state S
        10'b0000000010: output_logic = 3'b000; // state S1
        10'b0000000100: output_logic = 3'b000; // state S11
        10'b0000001000: output_logic = 3'b000; // state S110
        10'b0000010000: output_logic = 3'b001; // state B0
        10'b0000100000: output_logic = 3'b010; // state B1
        10'b0001000000: output_logic = 3'b011; // state B2
        10'b0010000000: output_logic = 3'b100; // state B3
        10'b0100000000: output_logic = 3'b110; // state Count
        10'b1000000000: output_logic = 3'b101; // state Wait
        default: output_logic = 3'b000;         // default state
    endcase
end

assign done = output_logic[2];
assign counting = output_logic[1];
assign shift_ena = output_logic[0];

endmodule
