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
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State transition logic
always @(*)
begin
    case(state)
        // S
        10'b0000000001:
        begin
            if(d == 1)
                S_next = 10'b0000000010; // S1
            else
                S_next = 10'b0000000001; // S
        end
        // S1
        10'b0000000010:
        begin
            if(d == 1)
                S1_next = 10'b0000000100; // S11
            else
                S1_next = 10'b0000000001; // S
        end
        // S11
        10'b0000000100:
        begin
            if(d == 0)
                S11_next = 10'b0000000001; // S
            else
                S11_next = 10'b0000000100; // S11
        end
        // S110
        10'b0000001000:
        begin
            if(d == 0)
                S110_next = 10'b0000000001; // S
            else
                S110_next = 10'b1000000000; // B0
        end
        // B0
        10'b1000000000:
            B3_next = 10'b0100000000; // B1
        // B1
        10'b0100000000:
            B3_next = 10'b0010000000; // B2
        // B2
        10'b0010000000:
            B3_next = 10'b0001000000; // B3
        // B3
        10'b0001000000:
            B3_next = 10'b0110000000; // Count
        // Count
        10'b0110000000:
        begin
            if(done_counting == 0)
                Count_next = 10'b0110000000; // Count
            else
                Count_next = 10'b1100000000; // Wait
        end
        // Wait
        10'b1100000000:
        begin
            if(ack == 1)
                Wait_next = 10'b0000000001; // S
            else
                Wait_next = 10'b1100000000; // Wait
        end
        default:
        begin
            S_next = 10'b0000000001; // S
            S1_next = 10'b0000000001; // S
            S11_next = 10'b0000000001; // S
            S110_next = 10'b0000000001; // S
            B3_next = 10'b0000000001; // S
            Count_next = 10'b0000000001; // S
            Wait_next = 10'b0000000001; // S
        end
    endcase
end

// Output logic
always @(*)
begin
    case(state)
        // B3
        10'b0001000000:
        begin
            counting = 1;
            done = 0;
            shift_ena = 1;
        end
        // Count
        10'b0110000000:
        begin
            counting = 1;
            done = 0;
            shift_ena = 0;
        end
        // Wait
        10'b1100000000:
        begin
            counting = 0;
            done = 1;
            shift_ena = 0;
        end
        default:
        begin
            counting = 0;
            done = 0;
            shift_ena = 0;
        end
    endcase
end

endmodule
