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

reg [9:0] next_state;

always @(*) begin
    case(state)
        10'b0000000001: begin  // state S
            if (d == 0) begin
                S_next = 1;
            end
            else begin
                S_next = 0;
            end
        end
        
        10'b0000000010: begin  // state S1
            if (d == 0) begin
                S1_next = 1;
            end
            else begin
                S1_next = 0;
            end
        end
        
        10'b0001001110: begin  // state S110
            if (d == 0) begin
                S_next = 1;
            end
            else begin
                S_next = 0;
            end
        end
        
        10'b0010000000: begin  // state B0
            if (state[0] == 1 || state[1] == 1 || state[2] == 1 || state[3] == 1) begin
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
            end
        end
        
        10'b0010000001: begin  // state B1
            if (state[0] == 1 || state[1] == 1 || state[2] == 1 || state[3] == 1) begin
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
            end
        end
        
        10'b0010000010: begin  // state B2
            if (state[0] == 1 || state[1] == 1 || state[2] == 1 || state[3] == 1) begin
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
            end
        end
        
        10'b0010000011: begin  // state B3
            if (state[0] == 1) begin
                B3_next = 1;
            end
            else begin
                B3_next = 0;
            end
            
            if (state[0] == 1 || state[1] == 1 || state[2] == 1 || state[3] == 1) begin
                shift_ena = 1;
            end
            else begin
                shift_ena = 0;
            end
        end
        
        10'b0100000000: begin  // state Count
            if (state[0] == 1) begin
                Count_next = 1;
            end
            else begin
                Count_next = 0;
            end
            
            if (done_counting == 0) begin
                counting = 1;
            end
            else begin
                counting = 0;
            end
        end
        
        10'b1000000000: begin  // state Wait
            if (ack == 1) begin
                Wait_next = 1;
            end
            else begin
                Wait_next = 0;
            end
            
            if (done_counting == 1) begin
                done = 1;
            end
            else begin
                done = 0;
            end
        end
        
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
    endcase
end

assign next_state = 10'b0;

always @(posedge clk) begin
    state <= next_state;
end

endmodule
