module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

always@(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end else begin
        case (state)
            
            A: begin 
                if (w) state <= A;
                else state <= B;
            end
            
            B: begin 
                if (w) state <= D;
                else state <= C;
            end
            
            C: begin 
                if (w) state <= D;
                else state <= E;
            end
            
            D: begin 
                if (w) state <= A;
                else state <= F;
            end
            
            E: begin 
                if (w) state <= D;
                else state <= E;
            end
            
            F: begin 
                if (w) state <= D;
                else state <= C;
            end
        endcase
    end
end

always@(state) begin
    if (state == E || state == F) z <= 1;
    else z <= 0;
end

endmodule
