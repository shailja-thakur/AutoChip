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

// Define all the state variables
reg B3_next_reg;
reg S_next_reg;
reg S1_next_reg;
reg Count_next_reg;
reg Wait_next_reg;
reg done_reg;
reg counting_reg;
reg shift_ena_reg;

always @(state, d, done_counting, ack) begin

    // Implement the state transition logic
    case(state)
        10'b0000000001: begin
            S_next_reg = d ? 10'b0000000010 : 10'b0000000001;
        end
        10'b0000000010: begin
            S1_next_reg = d ? 10'b0000000100 : 10'b0000000001;
        end
        10'b0000000100: begin
            S1_next_reg = d ? 10'b0000000100 : 10'b0000000010;
        end
        10'b0000001000: begin
            S1_next_reg = d ? 10'b0000000100 : 10'b0000010000;
        end
        10'b0000010000: begin
            S_next_reg = d ? 10'b0000000001 : 10'b0000000001;
            B3_next_reg = d ? 10'b0000000001 : 10'b0000000001;
        end
        10'b0000100000: begin
            B3_next_reg = d ? 10'b0000000001 : 10'b0000010000;
        end
        10'b0001000000: begin
            B3_next_reg = d ? 10'b0000010000 : 10'b0000100000;
        end
        10'b0010000000: begin
            B3_next_reg = d ? 10'b0000100000 : 10'b0001000000;
        end
        10'b0100000000: begin
            Count_next_reg = done_counting ? 10'b0100000000 : 10'b0100000000;
        end
        10'b1000000000: begin
            Wait_next_reg = ack ? 10'b0000000001 : 10'b1000000000;
        end
        default: begin
            // Default case if no match found
            S_next_reg = 0;
            S1_next_reg = 0;
            Count_next_reg = 0;
            Wait_next_reg = 0;
            B3_next_reg = 0;
        end
    endcase

    // Implement the output logic
    done_reg = (state == 10'b1000000000 && ack == 1'b1) ? 1'b1 : 1'b0;
    counting_reg = (state == 10'b0100000000) ? 1'b1 : 1'b0;
    shift_ena_reg = (state >= 10'b0000010000 && state <= 10'b0010000000) ? 1'b1 : 1'b0;

end

// Assign the next-state and output logic values to the outputs
assign B3_next = B3_next_reg;
assign S_next = S_next_reg;
assign S1_next = S1_next_reg;
assign Count_next = Count_next_reg;
assign Wait_next = Wait_next_reg;
assign done = done_reg;
assign counting = counting_reg;
assign shift_ena = shift_ena_reg;

endmodule
