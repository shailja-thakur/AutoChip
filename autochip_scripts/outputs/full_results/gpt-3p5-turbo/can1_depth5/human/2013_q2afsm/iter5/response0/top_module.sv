module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

    // Define the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    
    // Define the outputs
    reg [2:0] g_reg;
    
    reg [1:0] state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (r[0] == 1'b1 && r[1:2] == 2'b00) begin
                        state <= B;
                    end else if (r[0] == 1'b0 && r[1] == 1'b1) begin
                        state <= C;
                    end else if (r[0] == 1'b0 && r[1:2] == 2'b00) begin
                        state <= D;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (r[0] == 1'b0) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                C: begin
                    if (r[1] == 1'b0) begin
                        state <= A;
                    end else begin
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
            A: g_reg <= 3'b000;
            B: g_reg <= 3'b001;
            C: g_reg <= 3'b010;
            D: g_reg <= 3'b100;
        endcase
    end
    
    assign g = g_reg;
    
endmodule
