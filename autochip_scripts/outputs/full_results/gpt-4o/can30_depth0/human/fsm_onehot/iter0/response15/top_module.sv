module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);
 
    always @(*) begin
        // Default values
        next_state = 10'b0;
        out1 = 0;
        out2 = 0;
        
        case (1'b1)  // Checking which state is currently active
            state[0]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001;  // S0 -> S1 if in==1, else stay in S0
            end
            state[1]: begin
                next_state = in ? 10'b0000000100 : 10'b0000000001;  // S1 -> S2 if in==1, else go to S0
            end
            state[2]: begin
                next_state = in ? 10'b0000001000 : 10'b0000000001;  // S2 -> S3 if in==1, else go to S0
            end
            state[3]: begin
                next_state = in ? 10'b0000010000 : 10'b0000000001;  // S3 -> S4 if in==1, else go to S0
            end
            state[4]: begin
                next_state = in ? 10'b0000100000 : 10'b0000000001;  // S4 -> S5 if in==1, else go to S0
            end
            state[5]: begin
                next_state = in ? 10'b0001000000 : 10'b1000000000;  // S5 -> S6 if in==1, else go to S8
            end
            state[6]: begin
                next_state = in ? 10'b0010000000 : 10'b0100000000;  // S6 -> S7 if in==1, else go to S9
            end
            state[7]: begin
                next_state = in ? 10'b0010000000 : 10'b0000000001;  // S7 -> remain in S7 if in==1, else go to S0
                out2 = 1;  // S7 output is (0, 1)
            end
            state[8]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001;  // S8 -> S1 if in==1, else go to S0
                out1 = 1;  // S8 output is (1, 0)
            end
            state[9]: begin
                next_state = in ? 10'b0000000010 : 10'b0000000001;  // S9 -> S1 if in==1, else go to S0
                out1 = 1;  // S9 output is (1, 1)
                out2 = 1;
            end
           default: begin
                next_state = 10'b0000000001;  // Default to S0 state
            end 
        endcase
    end
endmodule
