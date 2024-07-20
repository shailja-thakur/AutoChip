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
    case(state)
        0: begin
            if(a==1 && b==1) begin
              state = 1;
              q = 1;
            end else if(a==0 && b==0) begin
              state = 0;
              q = 0;
            end else if(a==0 && b==1) begin
              state = 1;
              q = 1;
            end else if(a==1 && b==0) begin
              state = 1;
              q = 0;
            end
        end
        
        1: begin
            if(a==0 && b==0) begin
              state = 0;
              q = 0;
            end else if(a==1 && b==0) begin
              state = 1;
              q = 0;
            end else if(a==0 && b==1) begin
              state = 1;
              q = 1;
            end
        end
    endcase
end

endmodule
