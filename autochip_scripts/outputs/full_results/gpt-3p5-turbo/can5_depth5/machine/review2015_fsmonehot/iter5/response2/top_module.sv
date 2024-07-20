module top_module(
    input wire d,
    input wire done_counting,
    input wire ack,
    input wire [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State definitions
localparam S = 10'b0000000001;
localparam S1 = 10'b0000000010;
localparam S11 = 10'b0000000100;
localparam S110 = 10'b0000001000;
localparam B0 = 10'b0000010000;
localparam B1 = 10'b0000100000;
localparam B2 = 10'b0001000000;
localparam B3 = 10'b0010000000;
localparam Count = 10'b0100000000;
localparam Wait = 10'b1000000000;

reg [9:0] next_state;

// State logic and next state assignments
always @* begin
    next_state = state;

    case(state)
        S: begin
            if(d == 0)
                next_state = S1;
            else
                next_state = S;
        end

        S1: begin
            if(d == 0)
                next_state = S110;
            else
                next_state = S11;
        end

        S11: next_state = S110;

        S110: begin
            if(d == 0)
                next_state = Wait;
            else
                next_state = S;
        end

        B0: next_state = B1;
        B1: next_state = B2;
        B2: next_state = B3;
        B3: next_state = B0;
        Count: begin
            if(done_counting == 0)
                next_state = Count;
        end
        Wait: begin
            if(ack == 0)
                next_state = Count;
        end
    endcase
end

// Output assignments
always @* begin
    B3_next = (next_state == B3);
    S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));
    S1_next = (state == S && d == 1);
    Count_next = (next_state == B3 || (state == Count && done_counting == 0));
    Wait_next = (next_state == Count && done_counting == 1) || (state == Wait && ack == 0);
end

// Additional outputs
assign done = (state == Wait);
assign counting = (state == Count);
assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);

endmodule
