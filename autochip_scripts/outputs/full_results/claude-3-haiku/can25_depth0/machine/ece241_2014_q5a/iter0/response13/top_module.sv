module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    parameter A = 2'b00, B = 2'b01, C = 2'b11;
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= C;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    if (x) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
                C: begin
                    if (x) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            A, B: z = 1'b0;
            C: z = 1'b1;
        endcase
    end

endmodule
