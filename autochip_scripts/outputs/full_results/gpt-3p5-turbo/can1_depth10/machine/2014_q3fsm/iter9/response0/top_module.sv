module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

parameter A = 4'b000;
parameter B = 4'b001;
parameter C = 4'b010;
parameter S10 = 4'b011;
parameter S11 = 4'b100;
parameter S20 = 4'b101;
parameter S21 = 4'b110;
parameter S22 = 4'b111;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state or s or w) begin
    next_state = state;
    
    case (state)
        A: begin
            if (s) begin
                next_state = B;
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
        default: begin
            next_state = A;
        end
    endcase
end

always @(posedge clk) begin
    case (state)
        S20: begin
            z <= 1'b1;
        end
        default: begin
            z <= 1'b0;
        end
    endcase
end

endmodule
