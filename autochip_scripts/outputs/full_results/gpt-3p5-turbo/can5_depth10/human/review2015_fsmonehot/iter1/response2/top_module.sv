module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output reg done,
    output counting,
    output reg shift_ena
);

always @* begin
    case(state)
        10'b0000000001: S_next = ~d; // S
        10'b0000000010: S1_next = d; // S1
        10'b0000000100: begin // S11
            if(d==0)
                state = 10'b0000000001; // next state is S
            else
                state = 10'b0000000110; // next state is S11
        end
        10'b0000000110: begin // S110
            if(d==0)
                state = 10'b0000000001; // next state is S
            else
                state = 10'b0000010000; // next state is B0
        end
        10'b0000010000: begin // B0
            shift_ena = 1; // output always 1
            state = 10'b0000100000; // next state is B1
        end
        10'b0000100000: begin // B1
            shift_ena = 1; // output always 1
            state = 10'b0001000000; // next state is B2
        end
        10'b0001000000: begin // B2
            shift_ena = 1; // output always 1
            state = 10'b0010000000; // next state is B3
        end
        10'b0010000000: begin // B3
            shift_ena = 1; // output always 1
            state = 10'b0100000000; // next state is Count
        end
        10'b0100000000: begin // Count
            counting = 1; // output always 1
            if(done_counting)
                state = 10'b1000000000; // next state is Wait
        end
        10'b1000000000: begin // Wait
            counting = 0; // output always 0
            if(ack==1)
                state = 10'b0000000001; // next state is S
        end
        default: state = 10'b0000000001; // default state is S
    endcase
end

always @(posedge clk) begin
    done = (state == 10'b0010000000); // Output done is 1 when state is B3
end

endmodule
