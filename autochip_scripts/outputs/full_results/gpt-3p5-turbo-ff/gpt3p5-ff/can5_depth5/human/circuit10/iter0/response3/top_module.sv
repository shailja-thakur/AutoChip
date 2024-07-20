module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg q;
    reg state;
    always @(posedge clk) begin
        state <= state;
        case (state)
            0: begin
                if (a == 0 && b == 0)
                    q <= 0;
                else
                    q <= q;
                
                if (a == 0 && b == 1)
                    state <= 1;
                else if (a == 1 && b == 0)
                    state <= 2;
                else
                    state <= state;
            end
            1: begin
                if (a == 0 && b == 1)
                    q <= 1;
                else
                    q <= q;
                    
                if (a == 1 && b == 0)
                    state <= 3;
                else if (a == 0 && b == 0)
                    state <= 0;
                else
                    state <= state;
            end
            2: begin
                if (a == 1 && b == 0)
                    q <= 1;
                else
                    q <= q;
                    
                if (a == 0 && b == 0)
                    state <= 0;
                else if (a == 1 && b == 1)
                    state <= 4;
                else
                    state <= state;
            end
            3: begin
                if (a == 0 && b == 0)
                    q <= 0;
                else
                    q <= q;
                    
                if (a == 1 && b == 1)
                    state <= 5;
                else if (a == 0 && b == 1)
                    state <= 1;
                else
                    state <= state;
            end
            4: begin
                if (a == 1 && b == 1)
                    q <= 0;
                else
                    q <= q;
                    
                if (a == 0 && b == 1)
                    state <= 1;
                else if (a == 0 && b == 0)
                    state <= 0;
                else if (a == 1 && b == 0)
                    state <= 3;
                else
                    state <= state;
            end
            5: begin
                if (a == 1 && b == 1)
                    q <= 1;
                else
                    q <= q;
                    
                if (a == 0 && b == 0)
                    state <= 0;
                else if (a == 1 && b == 0)
                    state <= 3;
                else
                    state <= state;
            end
            default: begin
                q <= q;
                state <= state;
            end
        endcase
    end
endmodule
