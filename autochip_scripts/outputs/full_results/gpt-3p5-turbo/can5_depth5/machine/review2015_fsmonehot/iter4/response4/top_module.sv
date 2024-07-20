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

// State logic and next state assignments
always @* begin
    case(state)
        S: begin
            S_next = ~(d & state[9]);
            S1_next = d;
            Count_next = 0;
            Wait_next = 0;
        end
        S1: begin
            S_next = ~(d & state[9]);
            S1_next = d;
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
            Wait_next = 0;
        end
        B0: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        B1: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        B2: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        B3: begin
            B3_next = 1;
            S_next = B2;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        Count: begin
            S_next = 0;
            S1_next = 0;
            Count_next = done_counting;
            Wait_next = 0;
        end
        Wait: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = ~ack;
        end
        default: begin
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
end

// Output assignments
always @* begin
    done = state[4];
    counting = state[5];
    shift_ena = (state[6] || state[7] || state[8] || state[9]);
end

endmodule
