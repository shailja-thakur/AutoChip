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

// Define states
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000011;
parameter S110 = 10'b0000000100;
parameter B0 = 10'b0000000101;
parameter B1 = 10'b0000000110;
parameter B2 = 10'b0000000111;
parameter B3 = 10'b0000001000;
parameter Count = 10'b0000001001;
parameter Wait = 10'b0000001010;

// Assign default values to outputs
assign B3_next = 0;
assign S_next = 0;
assign S1_next = 0;
assign Count_next = 0;
assign Wait_next = 0;
assign done = 0;
assign counting = 0;
assign shift_ena = 0;

// Check state conditions and set outputs accordingly
always @(state, d, done_counting, ack) begin
    case (state)
        S: begin
            if (d == 0)
                S_next = 1;
        end
        S1: begin
            if (d == 0)
                S1_next = 1;
        end
        S110: begin
            if (d == 0)
                S_next = 1;
        end
        Wait: begin
            if (ack == 1)
                Wait_next = 1;
        end
        default: begin
            S_next = 0;
            S1_next = 0;
            Wait_next = 0;
        end
    endcase
end

always @(state) begin
    case (state)
        B2: begin
            B3_next = 1;
        end
        default: begin
            B3_next = 0;
        end
    endcase
end

always @(state, done_counting) begin
    case (state)
        B3: begin
            Count_next = 1;
        end
        Count: begin
            if (done_counting == 0)
                Count_next = 1;
        end
        default: begin
            Count_next = 0;
        end
    endcase
end

always @(state, done_counting, ack) begin
    case (state)
        Count: begin
            if (done_counting == 1)
                Wait_next = 1;
        end
        Wait: begin
            if (ack == 0)
                Wait_next = 1;
        end
        default: begin
            Wait_next = 0;
        end
    endcase
end

always @(state) begin
    case (state)
        B3, B2, B1, B0: begin
            shift_ena = 1;
        end
        default: begin
            shift_ena = 0;
        end
    endcase
end

always @(state) begin
    case (state)
        Wait: begin
            done = 1;
        end
        default: begin
            done = 0;
        end
    endcase
end

always @(state) begin
    case (state)
        Count: begin
            counting = 1;
        end
        default: begin
            counting = 0;
        end
    endcase
end

endmodule
