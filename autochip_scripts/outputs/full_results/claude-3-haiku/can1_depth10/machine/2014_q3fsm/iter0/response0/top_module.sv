module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, S10 = 4'b0011, S11 = 4'b0100, S20 = 4'b0101, S21 = 4'b0110, S22 = 4'b0111;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= state;
                end
            end
            B: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            end
            C: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            end
            S10: begin
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
            end
            S11: begin
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
            end
            S20: begin
                state <= B;
            end
            S21: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            end
            S22: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

always @(state) begin
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
            z <= 0;
        end
        S22: begin
            z <= 0;
        end
        default: begin
            z <= 0;
        end
    endcase
end

endmodule
