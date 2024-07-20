module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// State encoding
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 3'b100, F = 3'b101;

// State registers
reg [2:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (w) next_state = B;
            else   next_state = A;
        end
        B: begin
            if (w) next_state = C;
            else   next_state = D;
        end
        C: begin
            if (w) next_state = E;
            else   next_state = D;
        end
        D: begin
            if (w) next_state = F;
            else   next_state = A;
        end
        E: begin
            if (w) next_state = E;
            else   next_state = D;
        end
        F: begin
            if (w) next_state = C;
            else   next_state = D;
        end
        default: next_state = A;
    endcase
end

// State register
always @(posedge clk or posedge reset) begin
    if (reset) state <= A;
    else       state <= next_state;
end

// Output logic
assign z = (state == E) || (state == F);

endmodule
