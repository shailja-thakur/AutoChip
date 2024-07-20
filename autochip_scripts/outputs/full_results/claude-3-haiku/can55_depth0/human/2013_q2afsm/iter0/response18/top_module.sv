module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// State encoding
localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (r[1]) next_state = B;
            else if (r[2]) next_state = C;
            else if (r[3]) next_state = D;
            else next_state = A;
        end
        B: begin
            if (r[1]) next_state = B;
            else next_state = A;
        end
        C: begin
            if (r[2]) next_state = C;
            else next_state = A;
        end
        D: begin
            next_state = A;
        end
        default: next_state = A;
    endcase
end

// State register
always @(posedge clk or negedge resetn) begin
    if (~resetn) state <= A;
    else state <= next_state;
end

// Output logic
assign g[1] = (state == B);
assign g[2] = (state == C);
assign g[3] = (state == D);

endmodule
