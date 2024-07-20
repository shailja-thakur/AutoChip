module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

    // State transition logic
    always @* begin
        case(state)
            10'b1_000_000_000: begin // S0
                if(in == 1)
                    next_state = 10'b0_001_000_000; // S1
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_001_000_000: begin // S1
                if(in == 1)
                    next_state = 10'b0_000_001_000; // S2
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_001_000: begin // S2
                if(in == 1)
                    next_state = 10'b0_000_000_001; // S3
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_000_001: begin // S3
                if(in == 1)
                    next_state = 10'b0_000_000_010; // S4
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_000_010: begin // S4
                if(in == 1)
                    next_state = 10'b0_000_000_101; // S5
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_000_101: begin // S5
                if(in == 1)
                    next_state = 10'b1_000_000_000; // S8
                else
                    next_state = 10'b0_000_000_110; // S6
            end
            10'b0_000_000_110: begin // S6
                if(in == 1)
                    next_state = 10'b0_000_000_111; // S7
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_000_111: begin // S7
                if(in == 1)
                    next_state = 10'b0_000_000_111; // S7
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_001_000: begin // S8
                if(in == 1)
                    next_state = 10'b0_000_001_000; // S1
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            10'b0_000_010_000: begin // S9
                if(in == 1)
                    next_state = 10'b0_000_001_000; // S1
                else
                    next_state = 10'b1_000_000_000; // S0
            end
            default: next_state = 10'b1_000_000_000; // S0
        endcase
    end

    // Output logic
    assign out1 = (state == 10'b0_000_000_111 || state == 10'b0_000_010_000) ? 1'b1 : 1'b0;
    assign out2 = (state == 10'b0_000_010_000) ? 1'b1 : 1'b0;
    
endmodule
