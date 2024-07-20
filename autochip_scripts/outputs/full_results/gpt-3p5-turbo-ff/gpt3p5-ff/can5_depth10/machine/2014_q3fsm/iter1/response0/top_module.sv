module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

parameter A = 4'b0001;
parameter B = 4'b0010;
parameter C = 4'b0011;
parameter S10 = 4'b0100;
parameter S11 = 4'b0101;
parameter S20 = 4'b0110;
parameter S21 = 4'b0111;
parameter S22 = 4'b1000;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        C: begin
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
        default: next_state = A;
    endcase
end

always @(posedge clk) begin
    case(state)
        A: begin
            // Code for state A
            // ...
        end
        B: begin
            // Code for state B
            // ...
        end
        C: begin
            // Code for state C
            // ...
        end
        S10: begin
            // Code for state S10
            // ...
        end
        S11: begin
            // Code for state S11
            // ...
        end
        S20: begin
            // Code for state S20
            // ...
        end
        S21: begin
            // Code for state S21
            // ...
        end
        S22: begin
            // Code for state S22
            // ...
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        z <= 0;
    end else begin
        case(state)
            A: begin
                z <= 0;
            end
            B: begin
                z <= 1;
            end
            C: begin
                z <= 0;
            end
            S10: begin
                z <= 1;
            end
            S11: begin
                z <= 0;
            end
            S20: begin
                z <= 0;
            end
            S21: begin
                z <= 0;
            end
            S22: begin
                z <= 0;
            end
        endcase
    end
end

endmodule
