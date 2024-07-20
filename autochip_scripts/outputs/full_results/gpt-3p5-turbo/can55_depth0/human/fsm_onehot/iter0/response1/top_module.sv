module top_module (
input in,
input [9:0] state,
output [9:0] next_state,
output out1,
output out2);

// Define the next state logic
always @ (*) begin
    case (state)
        10'b0000000001: next_state = 10'b0000000001; // S0 -> S0, out1=0, out2=0
        10'b0000000001: next_state = 10'b0000000010; // S0 -> S1, out1=0, out2=0
        10'b0000000010: next_state = 10'b0000000001; // S1 -> S0, out1=0, out2=0
        10'b0000000010: next_state = 10'b0000000011; // S1 -> S2, out1=0, out2=0
        10'b0000000011: next_state = 10'b0000000001; // S2 -> S0, out1=0, out2=0
        10'b0000000011: next_state = 10'b0000000100; // S2 -> S3, out1=0, out2=0
        10'b0000000100: next_state = 10'b0000000001; // S3 -> S0, out1=0, out2=0
        10'b0000000100: next_state = 10'b0000000101; // S3 -> S4, out1=0, out2=0
        10'b0000000101: next_state = 10'b0000000001; // S4 -> S0, out1=0, out2=0
        10'b0000000101: next_state = 10'b0000000110; // S4 -> S5, out1=0, out2=0
        10'b0000000110: next_state = 10'b0000001000; // S5 -> S8, out1=0, out2=0
        10'b0000000110: next_state = 10'b0000000111; // S5 -> S6, out1=0, out2=0
        10'b0000000111: next_state = 10'b0000000001; // S6 -> S0, out1=0, out2=0
        10'b0000000111: next_state = 10'b0000001000; // S6 -> S9, out1=0, out2=0
        10'b0000001000: next_state = 10'b0000000001; // S7 -> S0, out1=0, out2=1
        10'b0000001000: next_state = 10'b0000001000; // S7 -> S7, out1=0, out2=1
        10'b0000001001: next_state = 10'b0000000001; // S8 -> S0, out1=1, out2=0
        10'b0000001001: next_state = 10'b0000000010; // S8 -> S1, out1=1, out2=0
        10'b0000001010: next_state = 10'b0000000001; // S9 -> S0, out1=1, out2=1
        10'b0000001010: next_state = 10'b0000000010; // S9 -> S1, out1=1, out2=1
        default: next_state = 10'b0000000001; // Default to S0 if invalid state
    endcase
end

// Define the output logic
always @ (*) begin
    case (state)
        10'b0000001000: begin // S7
            out1 = 0;
            out2 = 1;
        end
        10'b0000001001: begin // S8
            out1 = 1;
            out2 = 0;
        end
        10'b0000001010: begin // S9
            out1 = 1;
            out2 = 1;
        end
        default: begin
            out1 = 0;
            out2 = 0;
        end
    endcase
end

endmodule
