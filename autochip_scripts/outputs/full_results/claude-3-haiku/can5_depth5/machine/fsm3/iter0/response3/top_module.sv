module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        default: next_state = A;
    endcase
end

// Output logic
always @(state) begin
    out = (state == D);
end

endmodule
