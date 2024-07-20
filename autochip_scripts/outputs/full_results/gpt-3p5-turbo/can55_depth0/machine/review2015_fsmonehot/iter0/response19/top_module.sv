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
reg [9:0] next_state;

always @(*) begin
    // Default assignments
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;
  
    case (state)
        S: begin
            if (d == 0)
                S_next = 1;
        end
        S1: begin
            if (d == 0)
                S1_next = 1;
        end
        S110: begin
            if (d == 0)
                S_next = 1;
        end
        Wait: begin
            if (ack == 1)
                Wait_next = 1;
        end
        B3: begin
            B3_next = 1;
            shift_ena = 1;
        end
        B2: begin
            B3_next = 1;
            shift_ena = 1;
        end
        B1: begin
            B3_next = 1;
            shift_ena = 1;
        end
        B0: begin
            B3_next = 1;
            shift_ena = 1;
        end
        Count: begin
            Count_next = 1;
            counting = 1;
        end
    endcase
    
    if (state == Count) begin
        if (done_counting == 1)
            Wait_next = 1;
    end else if (state == Wait) begin
        if (ack == 0)
            Count_next = 1;
    end

    if (state == Wait)
        done = 1;
end

always @(posedge clk) begin
    state <= next_state;
end

endmodule
