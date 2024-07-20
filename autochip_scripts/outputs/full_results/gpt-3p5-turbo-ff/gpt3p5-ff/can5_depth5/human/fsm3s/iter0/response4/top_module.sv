module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state_reg;
    reg out_reg;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    always @(posedge clk) begin
        if (reset) begin
            state_reg <= A;
            out_reg <= 1'b0;
        end else begin
            case (state_reg)
                A: begin
                    if (in) begin
                        state_reg <= B;
                    end else begin
                        state_reg <= A;
                    end
                    out_reg <= 1'b0;
                end
                
                B: begin
                    if (in) begin
                        state_reg <= C;
                    end else begin
                        state_reg <= B;
                    end
                    out_reg <= 1'b0;
                end
                
                C: begin
                    if (in) begin
                        state_reg <= D;
                    end else begin
                        state_reg <= A;
                    end
                    out_reg <= 1'b0;
                end
                
                D: begin
                    if (in) begin
                        state_reg <= B;
                    end else begin
                        state_reg <= C;
                    end
                    out_reg <= 1'b1;
                end
            endcase
        end
    end
    
    assign out = out_reg;

endmodule
