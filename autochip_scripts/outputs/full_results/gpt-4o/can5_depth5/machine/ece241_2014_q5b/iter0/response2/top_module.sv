module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 1'b0, B = 1'b1;
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (x) 
                        state <= B;
                    else 
                        state <= A;
                end
                
                B: begin
                    state <= B;
                end
            
                default: begin
                    state <= A;
                end
            endcase
        end
    end

    always @(state or x) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
