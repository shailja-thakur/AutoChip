module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Combinational logic
always @* begin
    case (state)
        A: begin
            if (s)
                next_state = B;
            else
                next_state = A;
        end

        B, C: begin
            if (w)
                next_state = S11;
            else
                next_state = S10;
        end

        S10: begin
            if (w)
                next_state = S21;
            else
                next_state = S20;
        end
        
        S11: begin
            if (w)
                next_state = S22;
            else
                next_state = S21;
        end

        S20: begin
            next_state = B;
        end

        S21: begin
            if (w)
                next_state = C;
            else
                next_state = B;
        end

        S22: begin
            if (w)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A: begin
                z <= 0;
            end
            B, S10, S20: begin
                z <= 1;
            end
            C, S21, S22: begin
                z <= 0;
            end
        endcase
    end
end

endmodule
