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

// Define the states
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

// Combinational logic for the next states
always @*
begin
    B3_next = (state[B2] == 1'b1);
    S_next = ((state[S] && ~d) || (state[S1] && ~d) || (state[S110] && ~d) || (state[Wait] && ack));
    S1_next = (state[S] && d);
    Count_next = (state[B3] || (state[Count] && ~done_counting));
    Wait_next = ((state[Count] && done_counting) || (state[Wait] && ~ack));
end

// Sequential logic for the state transitions
always @(posedge clk)
begin
    if (reset)
    begin
        state <= S;
    end
    else
    begin
        case (state)
            S: state <= S_next ? S_next : S;    // Transition to S_next if S_next is active, otherwise remain in S
            S1: state <= S1_next ? S1_next : S;    // Transition to S1_next if S1_next is active, otherwise remain in S1
            S11: state <= S110;    // Transition directly to S110
            S110: state <= B0;    // Transition directly to B0
            B0: state <= B1;    // Transition to B1
            B1: state <= B2;    // Transition to B2
            B2: state <= B3;    // Transition to B3
            B3: state <= Count;    // Transition to count
            Count: state <= Count_next ? Count_next : Wait;    // Transition to Count_next if Count_next is active, otherwise transition to Wait
            Wait: state <= Wait_next ? Wait_next : Wait;    // Transition to Wait_next if Wait_next is active, otherwise remain in Wait
            default: state <= S;    // Default transition to S
        endcase
    end
end

// Output signals
assign done = (state == Wait);
assign counting = (state == Count);
assign shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]);

endmodule
