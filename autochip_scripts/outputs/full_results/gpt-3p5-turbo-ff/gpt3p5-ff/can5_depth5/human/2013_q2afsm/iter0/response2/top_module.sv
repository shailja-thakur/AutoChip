module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

reg [1:0] state, next_state;
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk) begin
    if(!resetn)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    g = 3'b000;
    
    case(state)
        A: begin
            if(r[0])
                next_state = B;
            else if(r[1])
                next_state = C;
            else if(r[2])
                next_state = D;
            else
                next_state = A;
        end
        
        B: begin
            if(r[0] && g[0])
                next_state = B;
            else if(r[0] && !g[0])
                next_state = A;
            else
                next_state = B;
        end
        
        C: begin
            if(r[1] && g[1])
                next_state = C;
            else if(r[1] && !g[1])
                next_state = A;
            else
                next_state = C;
        end
        
        D: begin
            next_state = A;
        end
    end
end

assign g[0] = (state == B);
assign g[1] = (state == C);
assign g[2] = (state == D);

endmodule
