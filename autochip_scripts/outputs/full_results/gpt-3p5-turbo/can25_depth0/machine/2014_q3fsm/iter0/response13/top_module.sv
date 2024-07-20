module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter [3:0] A = 4'b0001;
parameter [3:0] B = 4'b0010;
parameter [3:0] C = 4'b0011;
parameter [3:0] S10 = 4'b0100;
parameter [3:0] S11 = 4'b0101;
parameter [3:0] S20 = 4'b0110;
parameter [3:0] S21 = 4'b0111;
parameter [3:0] S22 = 4'b1000;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end

            B: begin
                if (w) begin
                    state <= S11;
                end else begin
                    state <= S10;
                end
            end

            C: begin
                if (w) begin
                    state <= S11;
                end else begin
                    state <= S10;
                end
            end

            S10: begin
                if (w) begin
                    state <= S21;
                end else begin
                    state <= S20;
                end
            end

            S11: begin
                if (w) begin
                    state <= S22;
                end else begin
                    state <= S21;
                end
            end

            S20: begin
                state <= B;
            end

            S21: begin
                if (w) begin
                    state <= C;
                end else begin
                    state <= B;
                end
            end

            S22: begin
                if (w) begin
                    state <= B;
                end else begin
                    state <= C;
                end
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

        S20, S21, S22: begin
            z <= 1;
        end
    endcase
end
endmodule
