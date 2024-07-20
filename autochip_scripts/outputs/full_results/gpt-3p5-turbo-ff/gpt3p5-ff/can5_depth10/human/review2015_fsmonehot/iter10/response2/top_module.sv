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

    always @(state or d or done_counting or ack) begin
        case(state)
            10'b0000000001: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0000000010: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0000000100: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0000001000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0000010000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0000100000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0001000000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0010000000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b0100000000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            10'b1000000000: begin
                S_next = d ? 1 : 0;
                S1_next = d ? 1 : 0;
                Count_next = done_counting ? 1 : 0;
                Wait_next = 0;
            end
            default: begin
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            B3_next <= 0;
            done <= 0;
            counting <= 0;
            shift_ena <= 0;
        end else begin
            B3_next <= state[6];
            done <= Wait_next;
            counting <= Count || (!B0 && !B1 && !B2 && !B3);
            shift_ena <= B0 || B1 || B2 || B3;
        end
    end

endmodule
