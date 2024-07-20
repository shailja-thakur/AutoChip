module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    reg [1:0] next_state;
    reg [2:0] w_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            next_state <= A;
            w_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            
            case(state)
                A: begin
                    if (s == 1)
                        next_state <= B;
                end
                
                B: begin
                    w_count <= (w == 1) ? (w_count + 1) : 0;
                    next_state <= B;
                    
                    if (w_count == 2)
                        next_state <= A;
                end
            endcase
        end
        
        if (state == A)
            z <= 0;
        else if (state == B && w_count == 2)
            z <= 1;
        else
            z <= 0;
    end

endmodule
