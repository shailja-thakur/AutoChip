module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
 
reg [1:0] state, next_state;

// Define the state transitions and outputs
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end
 
always @* begin
    next_state = state;
 
    case (state)
        A: begin
            case (w)
                1: next_state = A;
                0: next_state = B;
            endcase
        end
        B: begin
            case (w)
                1: next_state = D;
                0: next_state = C;
            endcase
        end
        C: begin
            case (w)
                1: next_state = D;
                0: next_state = E;
            endcase
        end
        D: begin
            case (w)
                1: next_state = A;
                0: next_state = F;
            endcase
        end
        E: begin
            case (w)
                1: next_state = D;
                0: next_state = E;
            endcase
        end
        F: begin
            case (w)
                1: next_state = D;
                0: next_state = C;
            endcase
        end
        default: next_state = A;
    endcase
end
 
always @(posedge clk) begin
    case (state)
        A: z <= 1'b0;
        E: z <= 1'b1;
        default: z <= 1'b1;
    endcase
end
 
endmodule
