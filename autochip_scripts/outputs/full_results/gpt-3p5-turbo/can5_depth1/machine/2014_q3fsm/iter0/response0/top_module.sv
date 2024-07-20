module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter S10 = 2'b11;
parameter S11 = 2'b00;
parameter S20 = 2'b01;
parameter S21 = 2'b10;
parameter S22 = 2'b11;

reg [1:0] state, next_state; // Current state and next state

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A; // Reset to state A
    end else begin
        state <= next_state;
    end
end

always @* begin
    // Default next state is the same as the current state
    next_state = state;

    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end
        end

        B, C: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end

        S10: begin
            if (w) begin
                next_state = S21;
            end else begin
                next_state = S20;
            end
        end

        S11: begin
            if (w) begin
                next_state = S22;
            end else begin
                next_state = S21;
            end
        end

        S20: begin
            next_state = B;
        end

        S21: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end

        S22: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        z <= 0; // Reset output to 0
    end else begin
        if (state == S20 || state == S21 || state == S22) begin
            z <= 1; // Set output to 1 in states S20, S21, and S22
        end else begin
            z <= 0;
        end
    end
end

endmodule
