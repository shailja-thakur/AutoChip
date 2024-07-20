module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
  
    // Logic for state transition
    always @(*)
    begin
        case (state)
            10'b0000000001: next_state = 10'b0000000100; // S0 --0--> S0
            10'b0000000001: next_state = 10'b0000000010; // S0 --1--> S1
            10'b0000000010: next_state = 10'b0000000100; // S1 --0--> S0
            10'b0000000010: next_state = 10'b0000000111; // S1 --1--> S2
            10'b0000000011: next_state = 10'b0000000100; // S2 --0--> S0
            10'b0000000011: next_state = 10'b0000001001; // S2 --1--> S3
            10'b0000000100: next_state = 10'b0000000100; // S3 --0--> S0
            10'b0000000100: next_state = 10'b0000001100; // S3 --1--> S4
            10'b0000000101: next_state = 10'b0000000100; // S4 --0--> S0
            10'b0000000101: next_state = 10'b0000010100; // S4 --1--> S5
            10'b0000000110: next_state = 10'b0001001000; // S5 --0--> S8
            10'b0000000110: next_state = 10'b0000100010; // S5 --1--> S6
            10'b0000000111: next_state = 10'b0010100100; // S6 --0--> S9
            10'b0000000111: next_state = 10'b0001111110; // S6 --1--> S7
            10'b0000001111: next_state = 10'b0000000100; // S7 --0--> S0
            10'b0000001111: next_state = 10'b0001111110; // S7 --1--> S7
            10'b0000100000: next_state = 10'b0000000100; // S8 --0--> S0
            10'b0000100000: next_state = 10'b0000000010; // S8 --1--> S1
            10'b0001000000: next_state = 10'b0000000100; // S9 --0--> S0
            10'b0001000000: next_state = 10'b0000000010; // S9 --1--> S1
            default: next_state = 10'b0000000100; // Default case, transition to S0
        endcase
    end
  
    // Logic for output
    always @(*)
    begin
        case (state)
            10'b0000000000, 10'b0000000100, 10'b0000001000, 10'b0000001100, 10'b0000010100, 10'b0000100010, 10'b0000100101, 10'b0000100110, 10'b0000100111: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
            10'b0000001111: begin
                out1 = 1'b0;
                out2 = 1'b1;
            end
            10'b0001000000, 10'b0010100100, 10'b0100100010, 10'b0111110111: begin
                out1 = 1'b1;
                out2 = 1'b0;
            end
            default: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end
  
endmodule
