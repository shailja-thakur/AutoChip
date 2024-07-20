module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    // State encoding: A = 0, B = 1, C = 2, D = 3, E = 4, F = 5
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                A: begin
                    if (w)
                        next_state = B;
                    else
                        next_state = A;
                end
                
                B: begin
                    if (w)
                        next_state = C;
                    else
                        next_state = D;
                end
                
                C: begin
                    if (w)
                        next_state = E;
                    else
                        next_state = D;
                end
                
                D: begin
                    if (w)
                        next_state = F;
                    else
                        next_state = A;
                end
                
                E: begin
                    if (z)
                        next_state = E;
                    else
                        next_state = D;
                end
                
                F: begin
                    if (z)
                        next_state = C;
                    else
                        next_state = D;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            A: z = 0;
            E: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
