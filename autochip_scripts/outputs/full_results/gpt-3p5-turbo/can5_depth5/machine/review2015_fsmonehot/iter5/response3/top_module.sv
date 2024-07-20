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

reg [9:0] next_state;

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
            if (d == 0) begin
                next_state = S_next;
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                next_state = S1_next;
                S_next = 1'b0;
                S1_next = 1'b1;
            end
        end
        S1: begin
            if (d == 0) begin
                next_state = S_next;
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                next_state = S11;
                S_next = 1'b0;
                S1_next = 1'b0;
            end
        end
        S11: begin
            if (d == 0) begin
                next_state = S110;
                S_next = 1'b0;
                S1_next = 1'b0;
            end
            else begin
                next_state = S1_next;
                S_next = 1'b0;
                S1_next = 1'b1;
            end
        end
        S110: begin
            if (d == 0) begin
                next_state = S_next;
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                next_state = Wait;
                S_next = 1'b0;
                S1_next = 1'b0;
            end
        end
        Wait: begin
            if (ack == 1) begin
                next_state = S_next;
                S_next = 1'b1;
                S1_next = 1'b0;
            end
            else begin
                next_state = Wait_next;
                S_next = 1'b0;
                S1_next = 1'b0;
            end
        end
        default: begin
            next_state = state;
            S_next = 1'b0;
            S1_next = 1'b0;
        end
    endcase
end

// Output assignments
always @(state, next_state) begin
    B3_next = (state == B2);
    Count_next = (state == B3 || (state == Count && done_counting == 0));
    Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
    shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
    done = (state == Wait_next);
    counting = (state == Count_next);
end

endmodule
