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
 
    reg [9:0] next_state;
    
    always @(*) begin
        case(state)
            S: begin
                if (d == 0)
                    next_state = 3'b000;  // Transition to S1
                else
                    next_state = 3'b001;  // Transition to S11
            end
            S1: begin
                if (d == 0)
                    next_state = 3'b001;  // Transition to S11
                else
                    next_state = 3'b010;  // Transition to S110
            end
            S11: begin
                if (d == 0)
                    next_state = 3'b010;  // Transition to S110
                else
                    next_state = 3'b011;  // Transition to B0
            end
            S110: begin
                if (d == 0)
                    next_state = 3'b011;  // Transition to B0
                else if (ack == 1)
                    next_state = 3'b101;  // Transition to Wait
                else
                    next_state = 3'b001;  // Transition to S11
            end
            B0: begin
                next_state = 3'b100;  // Transition to B1
            end
            B1: begin
                next_state = 3'b101;  // Transition to Wait
            end
            B2: begin
                next_state = 3'b110;  // Transition to B3
            end
            B3: begin
                if (done_counting == 0)
                    next_state = 3'b110;  // Stay in B3
                else
                    next_state = 3'b100;  // Transition to B1
            end
            Count: begin
                if (done_counting == 0)
                    next_state = 3'b111;  // Stay in Count
                else
                    next_state = 3'b100;  // Transition to B1
            end
            Wait: begin
                if (ack == 0)
                    next_state = 3'b111;  // Stay in Wait
                else
                    next_state = 3'b000;  // Transition to S
            end
            default: next_state = 3'b000;  // Default case
        endcase
    end
    
    always @(posedge clk) begin
        state <= next_state;
        B3_next <= (state == 3'b010);
        S_next <= ((state == 3'b000 && d == 0) || (state == 3'b001 && d == 0) 
                || (state == 3'b010 && d == 0) || (state == 3'b101 && ack == 1));
        S1_next <= (state == 3'b000 && d == 1);
        Count_next <= (state == 3'b011 || (state == 3'b111 && done_counting == 0));
        Wait_next <= (state == 3'b111 && done_counting == 1) || (state == 3'b101 && ack == 0);
        done <= (state == 3'b111);
        counting <= (state == 3'b100 || state == 3'b110 || state == 3'b111);
        shift_ena <= (state == 3'b100 || state == 3'b110 || state == 3'b101 || state == 3'b110);
    end

endmodule
