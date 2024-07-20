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
    parameter S = 10'b0000_0000_01;
    parameter S1 = 10'b0000_0000_10;
    parameter S11 = 10'b0000_0001_00;
    parameter S110 = 10'b0000_0010_00;
    parameter B0 = 10'b0000_0100_00;
    parameter B1 = 10'b0000_1000_00;
    parameter B2 = 10'b0001_0000_00;
    parameter B3 = 10'b0010_0000_00;
    parameter Count = 10'b0100_0000_00;
    parameter Wait = 10'b1000_0000_00;
	
    // Intermediate signals
    reg shift_ena_temp;
    reg S_next_temp;
    reg S_next_temp2;
    reg S1_next_temp;
    reg Wait_next_temp;
    reg Wait_next_temp2;

    // State machine logic
    always @(state) begin
        B3_next = (state == B2);
        S_next_temp = (state == S) & !d;
        S_next_temp2 = (state == S1) & !d;
        S1_next_temp = (state == S) & d;
        Wait_next_temp = (state == Count) & done_counting;
        Wait_next_temp2 = (state == Wait) & !ack;
    end

    // Output assign statements
    assign shift_ena = B3 | B2 | B1 | B0;
    assign S_next = S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
    assign S1_next = S1_next_temp;
    assign Count_next = (state == B3) | (state == Count) & !done_counting;
    assign Wait_next = Wait_next_temp | (state == Wait) & ack;

    // Final state outputs
    always @(posedge clk) begin
        case (state)
            S: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            S1: begin
                done <= 0;
                counting <= 0;
                S1_next <= S1_next_temp;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            S11: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            S110: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            B0: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            B1: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            B2: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            B3: begin
                done <= 0;
                counting <= 0;
                B3_next <= 1;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            Count: begin
                done <= 0;
                counting <= 1;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            Wait: begin
                done <= 1;
                counting <= 0;
                Wait_next <= 1;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
            default: begin
                done <= 0;
                counting <= 0;
                Wait_next <= Wait_next_temp2;
                S_next <= S_next_temp | S_next_temp2 | (state == S110) & !d | Wait_next_temp2;
            end
        endcase
    end

endmodule
