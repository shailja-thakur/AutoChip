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

reg [9:0] next_state;	// 10-bit one-hot next state

always @(state, d, ack, done_counting) begin
    // S and d is 0, or S1 and d is 0, or S110 and d is 0, or Wait and ack is 1
    if ((state[0] && !d) || (state[1] && !d) || (state[3] && !d) || (state[8] && ack)) begin
        S_next = 1;
    end else begin
        S_next = 0;
    end
    
    // S and d is 1
    if (state[0] && d) begin
        S1_next = 1;
    end else begin
        S1_next = 0;
    end
    
    // B2 is active
    if (state[5]) begin
        B3_next = 1;
    end else begin
        B3_next = 0;
    end
    
    // B3 is active, or Count and done_counting is 0
    if (state[7] || (state[6] && !done_counting)) begin
        Count_next = 1;
    end else begin
        Count_next = 0;
    end
    
    // Count and done_counting is 1, or Wait and ack is 0
    if ((state[6] && done_counting) || (state[8] && !ack)) begin
        Wait_next = 1;
    end else begin
        Wait_next = 0;
    end
    
    // shift_ena is 1 if any of the states B3, B2, B1, and B0 is active
    if (state[7] || state[5] || state[4] || state[2]) begin
        shift_ena = 1;
    end else begin
        shift_ena = 0;
    end
end

// Assign next state based on current state
always @(posedge clk) begin
    if (reset) begin
        next_state <= 10'b0000000001;    // Initial state
    end else begin
        next_state <= state;
    end
end

always @(next_state) begin
    // done signal is 1 in Wait state
    if (next_state == 10'b0000001000) begin
        done = 1;
    end else begin
        done = 0;
    end
    
    // counting signal is 1 in Count state
    if (next_state[6]) begin
        counting = 1;
    end else begin
        counting = 0;
    end
end

// Update state
always @(posedge clk) begin
    if (reset) begin
        state <= 10'b0000000001;    // Initial state
    end else begin
        state <= next_state;
    end
end

endmodule
