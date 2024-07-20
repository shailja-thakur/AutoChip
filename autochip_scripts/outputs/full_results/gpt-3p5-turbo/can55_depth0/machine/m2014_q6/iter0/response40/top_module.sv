module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Defining states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state; // Current state

always @(posedge clk) begin
    if (reset) begin
        state <= A; // Reset to state A
    end else begin
        case(state)
            A: begin
                if (w == 1'b0) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (w == 1'b1) begin
                    state <= D;
                end else begin
                    state <= C;
                end
            end
            C: begin
                if (w == 1'b1) begin
                    state <= D;
                end else begin
                    state <= E;
                end
            end
            D: begin
                if (w == 1'b0) begin
                    state <= F;
                end else begin
                    state <= A;
                end
            end
            E: begin
                if (w == 1'b1) begin
                    state <= D;
                end else begin
                    state <= E;
                end
            end
            F: begin
                if (w == 1'b0) begin
                    state <= C;
                end else begin
                    state <= D;
                end
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    if (state == E || state == F) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
