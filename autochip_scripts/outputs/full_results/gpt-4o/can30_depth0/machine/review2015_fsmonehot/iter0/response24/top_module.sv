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
    localparam S = 10'b0000000001, 
               S1 = 10'b0000000010, 
               S11 = 10'b0000000100, 
               S110 = 10'b0000001000, 
               B0 = 10'b0000010000, 
               B1 = 10'b0000100000, 
               B2 = 10'b0001000000, 
               B3 = 10'b0010000000, 
               Count = 10'b0100000000, 
               Wait = 10'b1000000000;

    // Combinational logic for outputs based on state
    always @(*) begin
        // Default values
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;
        
        // Transitions and outputs
        case (state)
            S: begin
                if (d == 1)
                    S1_next = 1;
                else
                    S_next = 1;
            end
            S1: begin
                if (d == 1)
                    S1_next = 1;
                else
                    S_next = 1;
            end
            S11: begin
                if (d == 0)
                    S_next = 1;
            end
            S110: begin
                if (d == 0)
                    S_next = 1;
            end
            B0, B1, B2, B3: begin
                shift_ena = 1;
                if (state == B2)
                    B3_next = 1;

                if (state == B3)
                    Count_next = 1;
            end
            Count: begin
                counting = 1;
                if (done_counting == 1)
                    Wait_next = 1;
                else
                    Count_next = 1;
            end
            Wait: begin
                done = 1;
                if (ack == 0)
                    Wait_next = 1;
                else
                    S_next = 1;
            end
        endcase
    end

endmodule
