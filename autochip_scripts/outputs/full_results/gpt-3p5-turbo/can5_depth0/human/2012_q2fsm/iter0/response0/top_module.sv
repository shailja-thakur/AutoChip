module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, nextState;

parameter A = 3'b001;
parameter B = 3'b010;
parameter C = 3'b011;
parameter D = 3'b100;
parameter E = 3'b101;
parameter F = 3'b110;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= nextState;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (w) begin
                nextState = B;
            end else begin
                nextState = A;
            end
        end

        B: begin
            if (w) begin
                nextState = C;
            end else begin
                nextState = D;
            end
        end

        C: begin
            if (w) begin
                nextState = E;
            end else begin
                nextState = D;
            end
        end

        D: begin
            if (w) begin
                nextState = F;
            end else begin
                nextState = A;
            end
        end

        E: begin
            if (w) begin
                nextState = E;
            end else begin
                nextState = D;
            end
        end

        F: begin
            if (w) begin
                nextState = C;
            end else begin
                nextState = D;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        A: begin
            z = 1'b0;
        end

        E: begin
            z = 1'b1;
        end

        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
