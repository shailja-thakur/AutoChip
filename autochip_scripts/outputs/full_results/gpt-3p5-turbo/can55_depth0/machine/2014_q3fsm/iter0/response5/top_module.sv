module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

// State Encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter S10 = 3'b011;
parameter S11 = 3'b100;
parameter S20 = 3'b101;
parameter S21 = 3'b110;
parameter S22 = 3'b111;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = A; // No change
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
    endcase
end

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A: begin
                z <= 0;
            end
            B: begin
                z <= 0;
            end
            C: begin
                z <= 0;
            end
            S10: begin
                z <= 0;
            end
            S11: begin
                z <= 0;
            end
            S20: begin
                z <= 0;
            end
            S21: begin
                z <= 1;
            end
            S22: begin
                z <= 1;
            end
        endcase
    end
end

endmodule
