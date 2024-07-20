module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encoding
localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// State registers
reg [2:0] current_state, next_state;

// State table
always @(*) begin
    case (current_state)
        A: begin
            if (w == 1'b0) next_state = A;
            else next_state = B;
        end
        B: begin
            if (w == 1'b0) next_state = D;
            else next_state = C;
        end
        C: begin
            if (w == 1'b0) next_state = D;
            else next_state = E;
        end
        D: begin
            if (w == 1'b0) next_state = A;
            else next_state = F;
        end
        E: begin
            if (w == 1'b0) next_state = D;
            else next_state = E;
        end
        F: begin
            if (w == 1'b0) next_state = D;
            else next_state = C;
        end
    endcase
end

// State flip-flops
always @(posedge clk) begin
    if (reset) current_state <= A;
    else current_state <= next_state;
end

// Output logic
assign z = (current_state == E) || (current_state == F);

endmodule
