module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk) begin
    if (reset == 1'b1) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, w) begin
    case(state)
        A: begin
            if (w == 1'b0) begin
                next_state <= B;
            end else begin
                next_state <= A;
            end
        end
        B: begin
            if (w == 1'b1) begin
                next_state <= D;
            end else begin
                next_state <= C;
            end
        end
        C: begin
            if (w == 1'b1) begin
                next_state <= D;
            end else begin
                next_state <= E;
            end
        end
        D: begin
            if (w == 1'b1) begin
                next_state <= A;
            end else begin
                next_state <= F;
            end
        end
        E: begin
            if (w == 1'b1) begin
                next_state <= D;
            end else begin
                next_state <= E;
            end
        end
        F: begin
            if (w == 1'b1) begin
                next_state <= D;
            end else begin
                next_state <= C;
            end
        end
    endcase
end

always @(state) begin
    if (state == E || state == F) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
