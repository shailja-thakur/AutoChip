module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;
localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (w) next_state = A;
            else next_state = B;
        end
        B: begin
            if (w) next_state = D;
            else next_state = C;
        end
        C: begin
            if (w) next_state = D;
            else next_state = E;
        end
        D: begin
            if (w) next_state = A;
            else next_state = F;
        end
        E: begin
            if (w) next_state = D;
            else next_state = E;
        end
        F: begin
            if (w) next_state = D;
            else next_state = C;
        end
    endcase
end

// State register
always @(posedge clk) begin
    if (reset) state <= A;
    else state <= next_state;
end

// Output logic
assign z = (state == E) || (state == F);

endmodule
