module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // State Enumeration
    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    
    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else begin
            case(state)
                A: if (w) state <= A; else state <= B;
                B: if (w) state <= D; else state <= C;
                C: if (w) state <= D; else state <= E;
                D: if (w) state <= A; else state <= F;
                E: if (w) state <= D; else state <= E;
                F: if (w) state <= D; else state <= C;
            endcase
        end
    end
    
    always @(state) begin
        if (state == E || state == F)
            z <= 1;
        else
            z <= 0;
    end
    
endmodule
