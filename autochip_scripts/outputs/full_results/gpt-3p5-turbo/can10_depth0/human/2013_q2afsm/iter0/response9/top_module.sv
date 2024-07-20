module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    reg [3:1] state, next_state;
    
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        
        case(state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
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
                if (r[1])
                    next_state = A;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
            end
            default: next_state = A;
        endcase
    end
    
    assign g[1] = (state == B || state == D);
    assign g[2] = (state == C || state == D);
    assign g[3] = (state == D);
    
endmodule
