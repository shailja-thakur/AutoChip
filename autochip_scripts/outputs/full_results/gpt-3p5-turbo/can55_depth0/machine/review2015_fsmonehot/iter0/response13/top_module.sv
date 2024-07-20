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

// Define the state values
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000100;
parameter S110 = 10'b0000001000;
parameter B0 = 10'b0000010000;
parameter B1 = 10'b0000100000;
parameter B2 = 10'b0001000000;
parameter B3 = 10'b0010000000;
parameter Count = 10'b0100000000;
parameter Wait = 10'b1000000000;

// Assign next state based on current state and input signals
always @* begin
    case(state)
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
                next_state = S;
        end
        S11: begin
            next_state = S110;
        end
        S110: begin
            if (d == 0)
                next_state = Wait_next ? Wait : S110;
            else
                next_state = S1;
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
            next_state = B2;
        end
        Count: begin
            if (done_counting == 0)
                next_state = Count_next ? B3 : Count;
            else
                next_state = Wait;
        end
        Wait: begin
            if (ack == 0)
                next_state = Wait_next ? Count : Wait;
            else
                next_state = S;
        end
        default: begin
            next_state = S;
        end
    endcase
end

// Assign outputs based on current state
always @* begin
    done = (state == Wait) ? 1'b1 : 1'b0;
    counting = (state == Count) ? 1'b1 : 1'b0;
    shift_ena = (state == B0 || state == B1 || state == B2 || state == B3) ? 1'b1 : 1'b0;
    S_next = (state == S && d == 0) ? 1'b1 : 1'b0;
    S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
    B3_next = (state == B2) ? 1'b1 : 1'b0;
    Count_next = (state == B3 || (state == Count && done_counting == 0)) ? 1'b1 : 1'b0;
    Wait_next = (state == Wait && ack == 0) ? 1'b1 : 1'b0;
end

// Assign next_state to state
always @(posedge clk) begin
    if (rst)
        state <= S;
    else
        state <= next_state;
end

endmodule
