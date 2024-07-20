module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    reg [1:0] state;
    reg z_reg;
    reg x_reg;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    
    always @(posedge clk or negedge areset) begin
        if (areset == 1'b0) begin
            state <= A;
            z_reg <= 1'b0;
        end else begin
            case (state)
                A: begin
                    if (x == 1'b0)
                        state <= A;
                    else if (x == 1'b1)
                        state <= B;
                    end
                B: begin
                    if (x == 1'b0)
                        state <= B;
                    else if (x == 1'b1)
                        state <= B;
                    end
                default: state <= A;
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            A: z_reg = 1'b0;
            B: z_reg = 1'b1;
            default: z_reg = 1'b0;
        endcase
    end
    
    always @(posedge clk) begin
        z <= z_reg;
        x_reg <= x;
    end
    
endmodule
