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

    // State encoding
    localparam S     = 10'b0000000001;
    localparam S1    = 10'b0000000010;
    localparam S11   = 10'b0000000100;
    localparam S110  = 10'b0000001000;
    localparam B0    = 10'b0000010000;
    localparam B1    = 10'b0000100000;
    localparam B2    = 10'b0001000000;
    localparam B3    = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Combinational logic for outputs
    always @(*) begin
        // Reset all outputs
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        // State-dependent outputs
        if (state[9]) begin
            // Wait state
            done = 1;
            if (ack == 1) begin
                S_next = 1;
            end else begin
                Wait_next = 1;
            end
        end else if (state[8]) begin
            // Count state
            counting = 1;
            if (done_counting == 1) begin
                Wait_next = 1;
            end else begin
                Count_next = 1;
            end
        end else if (state[7]) begin
            // B3 state
            shift_ena = 1;
            Count_next = 1;
        end else if (state[6]) begin
            // B2 state
            shift_ena = 1;
            B3_next = 1;
        end else if (state[5]) begin
            // B1 state
            shift_ena = 1;
        end else if (state[4]) begin
            // B0 state
            shift_ena = 1;
        end else if (state[3]) begin
            // S110 state
            if (d == 0) begin
                S_next = 1;
            end
        end else if (state[2]) begin
            // S11 state
        end else if (state[1]) begin
            // S1 state
            if (d == 1) begin
                S1_next = 1;
            end else begin
                S_next = 1;
            end
        end else if (state[0]) begin
            // S state
            if (d == 0) begin
                S_next = 1;
            end else begin
                S1_next = 1;
            end
        end
    end

endmodule
