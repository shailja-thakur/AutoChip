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

// Define the state encoding
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000100;
parameter S110 = 10'b0000001000;
parameter B0 = 10'b0000010000;
parameter B1 = 10'b0000100000;
parameter B2 = 10'b0001000000;
parameter B3 = 10'b0010000000;
parameter Count = 10'b0100000000;
parameter Wait = 10'b1000000000;

// State transition logic
always @(*) begin
    case(state)
        S: begin
            if(d == 1'b0)
                S_next = 1'b1;
            else if(d == 1'b1)
                S1_next = 1'b1;
        end
        S1: begin
            if(d == 1'b0)
                S_next = 1'b1;
            else if(d == 1'b1)
                S11_next = 1'b1;
        end
        S11: begin
            if(d == 1'b0)
                S110_next = 1'b1;
            else if(d == 1'b1)
                S11_next = 1'b1;
        end
        S110: begin
            if(d == 1'b0)
                S_next = 1'b1;
            else if(d == 1'b1)
                B0_next = 1'b1;
        end
        B0: begin
            B1_next = 1'b1;
            shift_ena = 1'b1;
        end
        B1: begin
            B2_next = 1'b1;
            shift_ena = 1'b1;
        end
        B2: begin
            B3_next = 1'b1;
            shift_ena = 1'b1;
        end
        B3: begin
            Count_next = 1'b1;
            shift_ena = 1'b1;
        end
        Count: begin
            if(done_counting)
                Wait_next = 1'b1;
            else
                Count_next = 1'b1;
            counting = 1'b1;
        end
        Wait: begin
            if(ack)
                S_next = 1'b1;
        end
    endcase
end

// Output logic
always @(*) begin
    case(state)
        B0: shift_ena = 1'b1;
        B1: shift_ena = 1'b1;
        B2: shift_ena = 1'b1;
        B3: shift_ena = 1'b1;
        Count: counting = 1'b1;
        Wait: done = 1'b1;
    endcase
end

endmodule
