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

// State definitions
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

reg [9:0] next_state;

// Combinational logic for next_state
always @(state, d, ack, done_counting) begin
    case(state)
        S: begin
            if (d == 0 && (state == S || state == S1 || state == S110 || (state == Wait && ack == 1))) begin
                next_state = S_next | S1;
            end
        end
        S1: begin
            if (d == 1 && state == S) begin
                next_state = S_next | S11;
            end
        end
        S11: begin
            if (state == S1) begin
                next_state = S_next | S110;
            end
        end
        S110: begin
            if (state == S11) begin
                next_state = S_next | Wait;
            end
        end
        B3: begin
            if (state == B2 || state == B3) begin
                next_state = B3_next | Count;
            end
        end
        Count: begin
            if (state == B3 || (state == Count && done_counting == 0)) begin
                next_state = Count_next | Wait;
            end
        end
        Wait: begin
            if (state == Count && done_counting == 1) begin
                next_state = Count_next | Wait_next;
            end
        end
    endcase
end

// Sequential logic for state transition
always @(posedge clk) begin
    state <= next_state;
end

// Assign outputs based on current state
always @(state) begin
    case(state)
        B3: begin
            B3_next = 1;
        end
        default: begin
            B3_next = 0;
        end
    endcase

    case(state)
        S: begin
            if (d == 0) begin
                S_next = 1;
            end else begin
                S_next = 0;
            end
        end
        S1: begin
            S1_next = 1;
        end
        default: begin
            S1_next = 0;
        end
    endcase

    case(state)
        Count: begin
            Count_next = 1;
        end
        default: begin
            Count_next = 0;
        end
    endcase

    case(state)
        Wait: begin
            Wait_next = 1;
        end
        default: begin
            Wait_next = 0;
        end
    endcase
end

// Assign outputs based on current state and signals
always @(state, ack, done_counting) begin
    done = (state == Wait) ? 1 : 0;
    counting = (state == Count) ? 1 : 0;
    
    if (state == B3 || state == B2 || state == B1 || state == B0) begin
        shift_ena = 1;
    end else begin
        shift_ena = 0;
    end
end

endmodule
