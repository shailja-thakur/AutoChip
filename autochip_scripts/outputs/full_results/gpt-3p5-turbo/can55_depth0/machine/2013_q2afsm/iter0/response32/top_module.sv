module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state, next;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        state <= 3'b000;
    else
        state <= next;
end

always @(state or r) begin
    case (state)
        3'b000: begin // State A
            if (r[1]) next = 3'b010; // Transition to state B if r[1] is high
            else if (r[2]) next = 3'b100; // Transition to state C if r[2] is high
            else if (r[3]) next = 3'b001; // Transition to state D if r[3] is high
            else next = 3'b000; // Transition back to state A
        end
        3'b010: begin // State B
            if (r[1]) next = 3'b010; // Stay in state B if r[1] is high
            else next = 3'b000; // Transition to state A otherwise
        end
        3'b100: begin // State C
            if (r[2]) next = 3'b100; // Stay in state C if r[2] is high
            else next = 3'b000; // Transition to state A otherwise
        end
        3'b001: begin // State D
            if (r[3]) next = 3'b001; // Stay in state D if r[3] is high
            else next = 3'b000; // Transition to state A otherwise
        end
    endcase
end

assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // g[1] is high if state is B
assign g[2] = (state == 3'b100) ? 1'b1 : 1'b0; // g[2] is high if state is C
assign g[3] = (state == 3'b001) ? 1'b1 : 1'b0; // g[3] is high if state is D

endmodule
