module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_next;
always@(posedge clk) begin
    case(state)
        0: begin
            if(a==0 && b==0)
                q_next = 0;
            else if(a==0 && b==1)
                q_next = 1;
            else
                q_next = q;
            state = (a==1 && q==1) ? 1 : 0;
        end
        1: begin
            if(a==0 && b==0)
                q_next = 0;
            else if(a==0 && b==1)
                q_next = 1;
            else
                q_next = q;
            state = (a==1 && q==1) ? 2 : 0;
        end
        2: begin
            if(a==0 && b==0)
                q_next = 0;
            else if(a==0 && b==1)
                q_next = 1;
            else
                q_next = q;
            state = (a==1 && q==1) ? 3 : 0;
        end
        3: begin
            if(a==0 && b==0)
                q_next = 0;
            else if(a==0 && b==1)
                q_next = 1;
            else
                q_next = q;
            state = (a==1 && q==1) ? 0 : 0;
        end
        default: begin
            q_next = q;
            state = 0;
        end
    endcase
end

always@(posedge clk) begin
    q = q_next;
end

endmodule
