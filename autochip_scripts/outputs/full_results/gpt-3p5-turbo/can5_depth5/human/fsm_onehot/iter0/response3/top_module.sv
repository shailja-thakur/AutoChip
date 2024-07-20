module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

// State transition logic
always @*
begin
    case (state)
        10'b1_000_000_000:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_001_000_000;
        
        10'b0_001_000_000:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_010_000;
        
        10'b0_010_000_000:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_010;
        
        10'b0_000_010_000:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_100;
        
        10'b0_000_000_010:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_101;
        
        10'b0_000_000_100:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_110;
        
        10'b0_000_000_101:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_111;
        
        10'b0_000_000_110:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_000;
        
        10'b0_000_000_111:
            if(in == 1'b0)
                next_state = 10'b1_000_000_000;
            else
                next_state = 10'b0_000_000_001;
        
        default:
            next_state = 10'b0_000_000_000; // Default state is S0
    endcase
end

// Output logic
assign out1 = (state[7] == 1'b1 || state[8] == 1'b1) ? 1'b1 : 1'b0;
assign out2 = (state[9] == 1'b1) ? 1'b1 : 1'b0;

endmodule
