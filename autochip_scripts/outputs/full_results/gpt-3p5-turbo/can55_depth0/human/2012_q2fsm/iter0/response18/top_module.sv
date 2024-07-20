module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
// Define states using parameters
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state_reg, state_next;
    
always @(posedge clk or posedge reset) begin
    if (reset)
        state_reg <= A;
    else
        state_reg <= state_next;
end

always @(state_reg or w) begin
    case (state_reg)
        A: if (w) state_next = B; else state_next = A;
        B: if (w) state_next = C; else state_next = D;
        C: if (w) state_next = E; else state_next = D;
        D: if (w) state_next = F; else state_next = A;
        E: if (w) state_next = E; else state_next = D;
        F: if (w) state_next = C; else state_next = D;
    endcase
end

assign z = (state_reg == E || state_reg == F);

endmodule
