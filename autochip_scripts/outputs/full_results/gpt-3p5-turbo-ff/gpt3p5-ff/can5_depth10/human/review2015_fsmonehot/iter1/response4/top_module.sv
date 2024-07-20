module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

    reg S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;

    always @(*) begin
        case(state)
            10'b0000000001: begin // S
                S_next = (d == 1) ? 10'b0000000010 : 10'b0000000001;
            end
            
            10'b0000000010: begin // S1
                S1_next = (d == 1) ? 10'b0000000100 : 10'b0000000001;
            end
            
            10'b0000000100: begin // S11
                S11_next = (d == 1) ? 10'b0000000010 : 10'b0000000011;
            end
            
            10'b0000000011: begin // S110
                S110_next = (d == 1) ? 10'b0000000001 : 10'b0010000000;
            end
            
            10'b0010000000: begin // B0
                B0_next = 10'b0100000000;
            end
            
            10'b0100000000: begin // B1
                B1_next = 10'b1000000000;
            end
            
            10'b1000000000: begin // B2
                B2_next = 10'b0010000000;
            end
            
            10'b0010000000: begin // B3
                B3_next = 10'b0010000000;
            end
            
            10'b1000000001: begin // Count
                Count_next = (done_counting == 1) ? 10'b0010000010 : 10'b1000000001;
            end
            
            10'b1000000001: begin // Wait
                Wait_next = (ack == 1) ? 10'b0000000001 : 10'b1000000001;
            end
        endcase
    end

    // Output logic
    always @(state) begin
        done = (state == 10'b1000000001) ? 1 : 0;
        counting = (state == 10'b0010000010) ? 1 : 0;
        shift_ena = (state[7:0] == 10'b0010000000) ? 1 : 0;
    end

endmodule
