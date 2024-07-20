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

always @(*) begin
    // Initialize outputs to 0
    B3_next = 1'b0;
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    // Assign outputs based on current state
    if (state[9]) begin // State S
        if (d == 1'b0) begin
            S_next = 1'b1;
        end
    end else if (state[8]) begin // State S1
        if (d == 1'b1) begin
            S1_next = 1'b1;
        end
    end else if (state[7]) begin // State S110
        if (d == 1'b0) begin
            S_next = 1'b1;
        end
    end else if (state[6]) begin // State Wait
        if (ack == 1'b1) begin
            S_next = 1'b1;
            done = 1'b1;
        end else begin
            Wait_next = 1'b1;
        end
    end else if (state[5]) begin // State B0
        shift_ena = 1'b1;
    end else if (state[4]) begin // State B1
        shift_ena = 1'b1;
    end else if (state[3]) begin // State B2
        shift_ena = 1'b1;
        B3_next = 1'b1;
    end else if (state[2]) begin // State B3
        shift_ena = 1'b1;
        Count_next = 1'b1;
    end else if (state[1]) begin // State Count
        if (done_counting == 1'b0) begin
            Count_next = 1'b1;
            counting = 1'b1;
        end else begin
            Wait_next = 1'b1;
        end
    end else if (state[0]) begin // State Wait
        if (ack == 1'b0) begin
            Wait_next = 1'b1;
        end else begin
            S_next = 1'b1;
            done = 1'b1;
        end
    end
end

endmodule
