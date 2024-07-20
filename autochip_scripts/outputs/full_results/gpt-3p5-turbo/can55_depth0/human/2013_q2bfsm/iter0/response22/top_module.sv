module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    
    case(state)
        A: begin
            if (~resetn) begin
                next_state = A;
                f = 0;
                g = 0;
            end else begin
                next_state = B;
                f = 1;
                g = 0;
            end
        end
        
        B: begin
            if (x == 1'b1) begin
                next_state = C;
                f = 0;
                g = 1;
            end else begin
                next_state = B;
                f = 0;
                g = 0;
            end
        end
        
        C: begin
            if (y == 1'b1) begin
                next_state = C;
                f = 0;
                g = 1;
            end else begin
                next_state = C;
                f = 0;
                g = 0;
            end
        end
    
        default: begin
            next_state = A;
            f = 0;
            g = 0;
        end
    endcase
end

endmodule
