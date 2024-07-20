module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state, next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State register
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[2]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
        end
        D: begin
            next_state = A;
        end
    endcase
end

// Output logic
assign g[1] = (state == B);
assign g[2] = (state == C);
assign g[3] = (state == D);

endmodule
