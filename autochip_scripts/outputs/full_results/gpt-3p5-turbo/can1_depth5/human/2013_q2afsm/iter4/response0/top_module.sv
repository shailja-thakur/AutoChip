module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // Define the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Define the outputs
    reg [3:1] g_reg;
    
    reg [1:0] state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (r[1] && !r[2] && !r[3]) begin
                        state <= A;
                    end else if (r[1]) begin
                        state <= B;
                    end else if (!r[1] && r[2]) begin
                        state <= C;
                    end else if (!r[1] && !r[2] && !r[3]) begin
                        state <= D;
                    end
                end
                B: begin
                    if (!r[1] && g_reg[1]) begin
                        state <= A;
                    end else if (r[1]) begin
                        state <= B;
                    end
                end
                C: begin
                    if (!r[2] && g_reg[2]) begin
                        state <= A;
                    end else if (r[2]) begin
                        state <= C;
                    end
                end
                D: begin
                    state <= A;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        case (state)
            A: g_reg <= {1'b0, 1'b0, 1'b0};
            B: g_reg <= {1'b0, 1'b0, 1'b1};
            C: g_reg <= {1'b0, 1'b1, 1'b0};
            D: g_reg <= {1'b1, 1'b0, 1'b0};
        endcase
    end
    
    assign g = g_reg;
    
endmodule
