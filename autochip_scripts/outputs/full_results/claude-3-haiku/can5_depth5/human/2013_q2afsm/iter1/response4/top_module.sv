module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Declare state variables
reg [1:0] current_state, next_state;

// Declare state codes
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// State flip-flops
always @(posedge clk) begin
    if (!resetn)
        current_state <= A;
    else
        current_state <= next_state;
end

// State table
always @(*) begin
    case (current_state)
        A: begin
            if (r[1])
                next_state = B;
            else if (r[2])
                next_state = C;
            else if (r[3])
                next_state = D;
            else
                next_state = A;
        end
        B: begin
            if (r[1])
                next_state = B;
            else
                next_state = A;
        end
        C: begin
            if (r[2])
                next_state = C;
            else
                next_state = A;
        end
        D: begin
            if (r[3])
                next_state = D;
            else
                next_state = A;
        end
        default:
            next_state = A;
    endcase
end

// Output logic
assign g[1] = (current_state == B);
assign g[2] = (current_state == C);
assign g[3] = (current_state == D);

endmodule
