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

// Internal signals
reg [9:0] nextState;

// Combinational logic for next state calculations
always @(*) begin
    case (state)
        // Calculating next state for S
        1'b0: begin
            if (d == 0)
                nextState = 1'b1;
            else
                nextState = state;
        end

        // Calculating next state for S1
        1'b1: begin
            if (d == 1)
                nextState = 2'b10;
            else
                nextState = state;
        end

        // Calculating next state for S11
        2'b10: begin
            if (d == 0)
                nextState = 3'b100;
            else
                nextState = state;
        end

        // Calculating next state for S110
        3'b100: begin
            if (d == 0)
                nextState = 4'b1011;
            else
                nextState = state;
        end

        // Calculating next state for B0
        4'b1011: begin
            if (state[3] == 1)
                nextState = 4'b1100;
            else
                nextState = state;
        end

        // Calculating next state for B1
        4'b1100: begin
            if (state[2] == 1)
                nextState = 4'b1101;
            else
                nextState = state;
        end

        // Calculating next state for B2
        4'b1101: begin
            if (state[1] == 1)
                nextState = 4'b1110;
            else
                nextState = state;
        end

        // Calculating next state for B3
        4'b1110: begin
            if (state[0] == 1)
                nextState = 4'b1110;
            else
                nextState = state;
        end

        // Calculating next state for Count
        4'b1111: begin
            if (done_counting == 0)
                nextState = 4'b1111;
            else
                nextState = 5'b10000;
        end

        // Calculating next state for Wait
        5'b10000: begin
            if (ack == 0)
                nextState = 5'b10000;
            else
                nextState = 5'b10001;
        end
        
        default: begin
            nextState = state;
        end
    endcase
end

// Sequential logic for output assignments
always @(posedge clk) begin
    // Assigning outputs based on current state
    case (state)
        // Assigning B3_next
        4'b1110: begin
            B3_next = 1'b1;
        end
        default: begin
            B3_next = 1'b0;
        end
    endcase

    case (state)
        // Assigning S_next
        1'b0, 1'b1, 3'b100, 5'b10000: begin
            if (d == 0 || (state == 1'b1 && d == 0) || (state == 3'b100 && d == 0) || (state == 5'b10000 && ack == 1))
                S_next = 1'b1;
            else
                S_next = 1'b0;
        end
        default: begin
            S_next = 1'b0;
        end
    endcase

    case (state)
        // Assigning S1_next
        1'b0: begin
            if (d == 1)
                S1_next = 1'b1;
            else
                S1_next = 1'b0;
        end
        default: begin
            S1_next = 1'b0;
        end
    endcase

    case (state)
        // Assigning Count_next
        4'b1110, 5'b10000: begin
            Count_next = 1'b1;
        end
        default: begin
            if (done_counting == 0)
                Count_next = 1'b1;
            else
                Count_next = 1'b0;
        end
    endcase

    case (state)
        // Assigning Wait_next
        4'b1111, 5'b10000: begin
            Wait_next = 1'b1;
        end
        default: begin
            if (ack == 0)
                Wait_next = 1'b1;
            else
                Wait_next = 1'b0;
        end
    endcase

    // Assigning done signal
    if (state == 5'b10000)
        done = 1'b1;
    else
        done = 1'b0;

    // Assigning counting signal
    if (state == 4'b1111)
        counting = 1'b1;
    else
        counting = 1'b0;

    // Assigning shift_ena signal
    if (state[3:0] == 4'b1110)
        shift_ena = 1'b1;
    else
        shift_ena = 1'b0;
end

endmodule
