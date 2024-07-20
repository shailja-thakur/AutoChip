module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

// State signals
reg [9:0] next_state;

// State assignments
always @(state, d, ack, done_counting) begin
    case(state)
        // S state
        10'b0000000001: begin
            if (d == 0 || (state[0] == 1 && ack == 1))
                next_state = 10'b0000000100;    // S_next
            else if (d == 1)
                next_state = 10'b0000000010;    // S1_next
            else
                next_state = state;
        end
        
        // S1 state
        10'b0000000010: begin
            if (d == 0)
                next_state = 10'b0000000100;    // S_next
            else
                next_state = state;
        end
        
        // S11 state
        10'b0000000100: begin
            next_state = 10'b0000011000;        // B0_next
        end
        
        // S110 state
        10'b0000001000: begin
            if (d == 0)
                next_state = 10'b0000000100;    // S_next
            else
                next_state = state;
        end
        
        // B0 state
        10'b0000010000: begin
            if (state[0] == 1)
                next_state = 10'b0000001000;    // S110_next
            else
                next_state = 10'b0000100000;    // B1_next
        end
        
        // B1 state
        10'b0000100000: begin
            if (state[1] == 1)
                next_state = 10'b0000010000;    // B0_next
            else
                next_state = 10'b0001000000;    // B2_next
        end
        
        // B2 state
        10'b0001000000: begin
            if (state[2] == 1)
                next_state = 10'b0000100000;    // B1_next
            else
                next_state = 10'b0010000000;    // B3_next
        end
        
        // B3 state
        10'b0010000000: begin
            if (state[3] == 1)
                next_state = 10'b0001000000;    // B2_next
            else
                next_state = 10'b0100000000;    // Count_next
        end
        
        // Count state
        10'b0100000000: begin
            if (done_counting == 0 || state[7:0] != 0)
                next_state = 10'b0100000000;    // Count_next
            else
                next_state = 10'b1000000000;    // Wait_next
        end
        
        // Wait state
        10'b1000000000: begin
            if (done_counting == 1)
                next_state = 10'b0100000000;    // Count_next
            else if (ack == 0)
                next_state = 10'b1000000000;    // Wait_next
            else
                next_state = 10'b0000010001;    // done
        end
        
        default:    // Default case
            next_state = state;
    endcase
end

// Output assignments
always @(next_state) begin
    B3_next = (next_state == 10'b0010000000) ? 1'b1 : 1'b0;
    S_next = ((next_state == 10'b0000000001 && d == 0) ||
              (next_state == 10'b0000000010 && d == 0) ||
              (next_state == 10'b0000001000 && d == 0) ||
              (next_state == 10'b1000000000 && ack == 1)) ? 1'b1 : 1'b0;
    S1_next = (next_state == 10'b0000000001 && d == 1) ? 1'b1 : 1'b0;
    Count_next = ((next_state == 10'b0010000000) || (next_state == 10'b0100000000 && done_counting == 0)) ? 1'b1 : 1'b0;
    Wait_next = ((next_state == 10'b0100000000 && done_counting == 1) || (next_state == 10'b1000000000 && ack == 0)) ? 1'b1 : 1'b0;
    done = (next_state == 10'b0000010001) ? 1'b1 : 1'b0;
    counting = (next_state == 10'b0100000000) ? 1'b1 : 1'b0;
    shift_ena = (next_state[3:0] != 4'b0000) ? 1'b1 : 1'b0;
end

// State transition
always @(posedge clk) begin
    state <= next_state;
end

endmodule
