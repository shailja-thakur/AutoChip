module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
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
            next_state = A;
        end
        default:
            next_state = A;
    endcase
end

// Output logic
always @(*) begin
    g[1] = 0;
    g[2] = 0;
    g[3] = 0;
    case (current_state)
        B: g[1] = 1;
        C: g[2] = 1;
        D: g[3] = 1;
    endcase
end

endmodule
