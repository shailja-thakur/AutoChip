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
    output done,
    output counting,
    output shift_ena
 );

reg [9:0] next_state;
reg [9:0] current_state;

always @(state)
    current_state = state;

always @(current_state, d)
begin
    case(current_state)
        S:
            begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        S1:
            begin
                if (d == 0)
                    S1_next = 1;
                else
                    S1_next = 0;
                S_next = 0;
                B3_next = 0;
            end

        S11:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        S110:
            begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        B0:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        B1:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        B2:
            begin
                S_next = 0;
                S1_next = 0;
                if (current_state == B2)
                    B3_next = 1;
                else
                    B3_next = 0;
            end

        B3:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end

        Count:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                if (current_state == B3 || done_counting == 0)
                    Count_next = 1;
                else
                    Count_next = 0;
            end

        Wait:
            begin
                if (ack == 1)
                    Wait_next = 0;
                else
                    Wait_next = 1;
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
            end
    endcase
end

assign done = (state == Wait);
assign counting = (state == Count);
assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);

endmodule
