module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

// State encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Next state logic based on current state and input w
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        case(state)
            A: begin
                if (w) begin
                    next_state <= A;
                end else begin
                    next_state <= B;
                end
            end
            B: begin
                if (w) begin
                    next_state <= D;
                end else begin
                    next_state <= C;
                end
            end
            C: begin
                if (w) begin
                    next_state <= D;
                end else begin
                    next_state <= E;
                end
            end
            D: begin
                if (w) begin
                    next_state <= A;
                end else begin
                    next_state <= F;
                end
            end
            E: begin
                if (w) begin
                    next_state <= D;
                end else begin
                    next_state <= E;
                end
            end
            F: begin
                if (w) begin
                    next_state <= D;
                end else begin
                    next_state <= C;
                end
            end
            default: next_state <= A;
        endcase
    end
end

// Current state assignment
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
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
