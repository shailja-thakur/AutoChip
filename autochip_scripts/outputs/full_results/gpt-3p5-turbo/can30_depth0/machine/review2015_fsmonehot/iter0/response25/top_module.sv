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

 // Define state parameters
 parameter S = 10'b000000001;
 parameter S1 = 10'b000000010;
 parameter S11 = 10'b000000100;
 parameter S110 = 10'b000001000;
 parameter B0 = 10'b000010000;
 parameter B1 = 10'b000100000;
 parameter B2 = 10'b001000000;
 parameter B3 = 10'b010000000;
 parameter Count = 10'b100000000;
 parameter Wait = 10'b000000000;

 // Define state signals
 reg [9:0] next_state;

 // Assigns value to next state based on current state and input signals
 always @ (state) begin
    case (state)
        S: begin
            if (d == 0)
                next_state = S_next ? S1 : S;
            else
                next_state = S;
        end
        S1: begin
            if (d == 0)
                next_state = S1_next ? S110 : S1;
            else
                next_state = S1;
        end
        S11: begin
            next_state = S110;
        end
        S110: begin
            if (d == 0)
                next_state = S110;
            else
                next_state = Wait_next ? Wait : S110;
        end
        B0: begin
            next_state = B1;
        end
        B1: begin
            next_state = B2;
        end
        B2: begin
            next_state = B3_next ? B3 : B2;
        end
        B3: begin
            if (done_counting == 0)
                next_state = Count_next ? Count : B3;
            else
                next_state = B3;
        end
        Count: begin
            if (done_counting == 1)
                next_state = Wait_next ? Wait : Count;
            else
                next_state = Count;
        end
        Wait: begin
            if (ack == 1)
                next_state = S_next ? S1 : Wait;
            else
                next_state = Wait;
        end
        default: next_state = state;
    endcase
 end
 
 // Assign outputs based on current state
 always @ (next_state, state) begin
    case (state)
        S: begin
            S_next = 1;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        S1: begin
            S_next = 0;
            S1_next = 1;
            Count_next = 0;
            Wait_next = 0;
        end
        S11: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        S110: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 1;
        end
        B0: begin
            B3_next = 0;
        end
        B1: begin
            B3_next = 0;
        end
        B2: begin
            B3_next = 1;
        end
        B3: begin
            B3_next = 0;
        end
        Count: begin
            B3_next = 0;
        end
        Wait: begin
            B3_next = 0;
        end
        default: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
 end
 
 // Assign done signal
 always @ (next_state) begin
    done = (next_state == Wait) ? 1 : 0;
 end
 
 // Assign counting signal
 always @ (next_state) begin
    counting = (next_state == Count) ? 1 : 0;
 end
 
 // Assign shift_ena signal
 always @ (next_state) begin
    shift_ena = (next_state == B3 || next_state == B2 || next_state == B1 || next_state == B0) ? 1 : 0;
 end
 
endmodule
