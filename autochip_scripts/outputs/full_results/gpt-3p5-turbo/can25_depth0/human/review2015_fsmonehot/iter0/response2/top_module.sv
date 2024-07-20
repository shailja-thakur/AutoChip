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

reg B3_next, S_next, S1_next, Count_next, Wait_next;
reg done, counting, shift_ena;

always @ (*) begin
    case (state)
        // S
        10'b0000000001:
            begin
                B3_next = 1'b0;  // B3_next
                S_next = d ? 10'b0000000010 : 10'b0000000001;  // S_next
                S1_next = d ? 10'b0000000100 : 10'b0000000001;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
        // S1
        10'b0000000010:
            begin
                B3_next = 1'b0;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = d ? 10'b0000000100 : 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
        // S11
        10'b0000000100:
            begin
                B3_next = 1'b0;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
        // S110
        10'b0000001000:
            begin
                B3_next = d ? 1'b1 : 1'b0;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
        // B0
        10'b0000010000:
            begin
                B3_next = 10'b0000100000;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b1;  // shift_ena
            end
        // B1
        10'b0000100000:
            begin
                B3_next = 10'b0001000000;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b1;  // shift_ena
            end
        // B2
        10'b0001000000:
            begin
                B3_next = 10'b0010000000;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b1;  // shift_ena
            end
        // B3
        10'b0010000000:
            begin
                B3_next = 10'b0000000001;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0000000000;  // Count_next
                Wait_next = 10'b0000000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b1;  // counting
                shift_ena = 1'b1;  // shift_ena
            end
        // Count
        10'b0100000000:
            begin
                B3_next = 10'b0001000000;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = done_counting ? 10'b1000000000 : 10'b0100000000;  // Count_next
                Wait_next = done_counting ? 10'b0000000001 : 10'b0100000000;  // Wait_next
                done = 1'b0;  // done
                counting = 1'b1;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
        // Wait
        10'b0000000001:
            begin
                B3_next = 10'b0000000001;  // B3_next
                S_next = 10'b0000000001;  // S_next
                S1_next = 10'b0000000010;  // S1_next
                Count_next = 10'b0100000000;  // Count_next
                Wait_next = ack ? 10'b0000000001 : 10'b1000000000;  // Wait_next
                done = 1'b1;  // done
                counting = 1'b0;  // counting
                shift_ena = 1'b0;  // shift_ena
            end
    endcase
end

endmodule
