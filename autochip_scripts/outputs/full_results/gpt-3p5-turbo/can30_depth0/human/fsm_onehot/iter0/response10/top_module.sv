module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // State transition logic
    always @(*) begin
        case (state)
            10'b01_00000000: next_state = 10'b01_00000000; // S0 (0, 0) --0--> S0
            10'b01_00000000: next_state = 10'b10_00000000; // S0 (0, 0) --1--> S1
            10'b10_00000000: next_state = 10'b01_00000000; // S1 (0, 0) --0--> S0
            10'b10_00000000: next_state = 10'b11_00000000; // S1 (0, 0) --1--> S2
            10'b11_00000000: next_state = 10'b01_00000000; // S2 (0, 0) --0--> S0
            10'b11_00000000: next_state = 10'b100_000000;  // S2 (0, 0) --1--> S3
            10'b100_000000:  next_state = 10'b01_00000000; // S3 (0, 0) --0--> S0
            10'b100_000000:  next_state = 10'b101_00000;   // S3 (0, 0) --1--> S4
            10'b101_000000:  next_state = 10'b01_00000000; // S4 (0, 0) --0--> S0
            10'b101_000000:  next_state = 10'b1100_00000;  // S4 (0, 0) --1--> S5
            10'b1100_00000:  next_state = 10'b1000_00000;  // S5 (0, 0) --0--> S8
            10'b1100_00000:  next_state = 10'b1100_00000;  // S5 (0, 0) --1--> S6
            10'b1100_00000:  next_state = 10'b1001_00000;  // S6 (0, 0) --0--> S9
            10'b1100_00000:  next_state = 10'b1100_00000;  // S6 (0, 0) --1--> S7
            10'b1100_00000:  next_state = 10'b01_00000000; // S7 (0, 1) --0--> S0
            10'b1100_00000:  next_state = 10'b1100_00000;  // S7 (0, 1) --1--> S7
            10'b1000_00000:  next_state = 10'b01_00000000; // S8 (1, 0) --0--> S0
            10'b1000_00000:  next_state = 10'b10_00000000; // S8 (1, 0) --1--> S1
            10'b1001_00000:  next_state = 10'b01_00000000; // S9 (1, 1) --0--> S0
            10'b1001_00000:  next_state = 10'b10_00000000; // S9 (1, 1) --1--> S1
            default: next_state = 10'b01_00000000; // Default next state is S0
        endcase
    end
    
    // Output logic
    assign out1 = (state == 10'b11_1000000) ? 1'b1 : 1'b0; // Output 1 logic for state S7 (0, 1)
    assign out2 = (state == 10'b1000_00000) ? 1'b1 : 1'b0; // Output 2 logic for state S8 (1, 0)
    
endmodule
