module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // Output wires (set to zero by default)
    wire [9:0] next_state;
    wire out1;
    wire out2;
    
    // State transition logic
    always @*
    begin
        case (state)
            // S0 transitions
            10'b0000000001: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0000000001: next_state = 10'b0000000010; // in=1, next_state=S1
            
            // S1 transitions
            10'b0000000010: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0000000010: next_state = 10'b0000000100; // in=1, next_state=S2
            
            // S2 transitions
            10'b0000000100: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0000000100: next_state = 10'b0000001000; // in=1, next_state=S3
            
            // S3 transitions
            10'b0000001000: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0000001000: next_state = 10'b0000001000; // in=1, next_state=S4
            
            // S4 transitions
            10'b0000001000: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0000001000: next_state = 10'b0000010000; // in=1, next_state=S5
            
            // S5 transitions
            10'b0000010000: next_state = 10'b0001000000; // in=0, next_state=S8
            10'b0000010000: next_state = 10'b0000100000; // in=1, next_state=S6
            
            // S6 transitions
            10'b0000100000: next_state = 10'b0010000000; // in=0, next_state=S9
            10'b0000100000: next_state = 10'b0001000000; // in=1, next_state=S7
            
            // S7 transitions
            10'b0001000000: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0001000000: next_state = 10'b0001000000; // in=1, next_state=S7
            
            // S8 transitions
            10'b0010000000: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0010000000: next_state = 10'b0000000010; // in=1, next_state=S1
            
            // S9 transitions
            10'b0100000000: next_state = 10'b0000000001; // in=0, next_state=S0
            10'b0100000000: next_state = 10'b0000000100; // in=1, next_state=S1
            
            default: next_state = 10'b0000000000; // Default state is S0
        endcase
    end
    
    // Output logic
    always @*
    begin
        case (state)
            // S0 outputs
            10'b0000000001: begin out1 = 0; out2 = 0; end
            
            // S1 outputs
            10'b0000000010: begin out1 = 0; out2 = 0; end
            
            // S2 outputs
            10'b0000000100: begin out1 = 0; out2 = 0; end
            
            // S3 outputs
            10'b0000001000: begin out1 = 0; out2 = 0; end
            
            // S4 outputs
            10'b0000010000: begin out1 = 0; out2 = 0; end
            
            // S5 outputs
            10'b0000100000: begin out1 = 0; out2 = 0; end
            
            // S6 outputs
            10'b0001000000: begin out1 = 0; out2 = 0; end
            
            // S7 outputs
            10'b0010000000: begin out1 = 0; out2 = 1; end
            
            // S8 outputs
            10'b0100000000: begin out1 = 1; out2 = 0; end
            
            // S9 outputs
            10'b1000000000: begin out1 = 1; out2 = 1; end
            
            default: begin out1 = 0; out2 = 0; end // Default outputs are zero
        endcase
    end
    
endmodule
