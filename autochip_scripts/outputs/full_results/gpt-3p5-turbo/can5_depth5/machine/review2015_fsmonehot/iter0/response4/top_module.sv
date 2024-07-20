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

parameter S = 10'b0000_0001;
parameter S1 = 10'b0000_0010;
parameter S11 = 10'b0000_0011;
parameter S110 = 10'b0000_0100;
parameter B0 = 10'b0000_0101;
parameter B1 = 10'b0000_0110;
parameter B2 = 10'b0000_0111;
parameter B3 = 10'b0000_1000;
parameter Count = 10'b0000_1001;
parameter Wait = 10'b0000_1010;

always @(state) begin
    case(state)
        S: begin
            if (d == 0) begin
                S_next = 1;
                S1_next = 0;
            end else begin
                S_next = 0;
                S1_next = 0;
            end
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S1: begin
            if (d == 1) begin
                S_next = 0;
                S1_next = 1;
            end else begin
                S_next = 0;
                S1_next = 0;
            end
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S11: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S110: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B0: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B1: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B2: begin
            S_next = 0;
            if (state == B2) begin
                B3_next = 1;
            end else begin
                B3_next = 0;
            end
            Count_next = 0;
            Wait_next = 0;
        end
        
        B3: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            if (state == B3) begin
                Count_next = 1;
            end else begin
                Count_next = 0;
            end
            Wait_next = 0;
        end
        
        Count: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = done_counting ? 0 : (state == B3);
            if (done_counting) begin
                Wait_next = 1;
            end else begin
                Wait_next = 0;
            end
        end
        
        Wait: begin
            S_next = (state == S) && (d == 0);
            S1_next = (state == S1) && (d == 0);
            B3_next = 0;
            Count_next = 0;
            Wait_next = (state == Wait) && (ack == 0);
        end
        
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
end

assign done = (state == Wait);
assign counting = (state == Count);
assign shift_ena = (state == B3) || (state == B2) || (state == B1) || (state == B0);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        done <= 0;
        counting <= 0;
        shift_ena <= 0;
    end else begin
        done <= (state == Wait);
        counting <= (state == Count);
        shift_ena <= (state == B3) || (state == B2) || (state == B1) || (state == B0);
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        B3_next <= 0;
        S_next <= 0;
        S1_next <= 0;
        Count_next <= 0;
        Wait_next <= 0;
    end else begin
        B3_next <= (state == B2);
        S_next <= (state == S) && (d == 0) || (state == S1) && (d == 0) || (state == S110) && (d == 0) || (state == Wait) && (ack == 1);
        S1_next <= (state == S) && (d == 1);
        Count_next <= (state == B3) || (state == Count) && (done_counting == 0);
        Wait_next <= (state == Count) && (done_counting == 1) || (state == Wait) && (ack == 0);
    end
end

endmodule
