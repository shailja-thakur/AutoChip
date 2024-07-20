module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;   // define register for current state

// state codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// state flip-flops
always @(posedge clk, negedge resetn)
begin
    if (~resetn)
        state <= A;   // reset state to A
    else
        state <= next_state;
end

// state table
always @(state or r)
begin
    case (state)
        A:
        begin
            if (r[1] && ~r[2] && ~r[3])
                next_state = B;
            else if (~r[1] && r[2] && ~r[3])
                next_state = C;
            else if (~r[1] && ~r[2] && ~r[3])
                next_state = D;
            else
                next_state = A;
        end
        
        B:
        begin
            if (r[1])
                next_state = B;
            else
                next_state = A;
        end
        
        C:
        begin
            if (r[2])
                next_state = C;
            else
                next_state = A;
        end
        
        default:
            next_state = A;
    endcase
end

// FSM outputs
always @(state)
begin
    g[1] = (state == B || state == D);
    g[2] = (state == C || state == D);
    g[3] = (state == D);
end

endmodule
