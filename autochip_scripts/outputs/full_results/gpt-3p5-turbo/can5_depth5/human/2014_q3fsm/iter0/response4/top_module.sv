module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, w) begin
    next_state = state;
    case (state)
        A: begin
            if (s == 1) begin
                next_state = B;
            end
        end
        
        B: begin
            if (w) begin
                case (state)
                    B: begin
                        next_state = B;
                    end
                    
                    default: begin
                        next_state = A;
                    end
                end
            end else begin
                next_state = B;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        B: begin
            z <= (w == 1'b1);
        end
        
        default: begin
            z <= 0;
        end
    endcase
end

endmodule
