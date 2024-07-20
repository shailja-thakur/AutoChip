module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [2:0] state, next_state;
    reg x_reg1, x_reg2, x_reg3;
    reg y_reg1, y_reg2;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            state <= 3'b000;
        end else begin
            next_state <= state;
            
            case (state)
                3'b000: begin // State A
                    if (!resetn) begin
                        next_state = 3'b001;
                    end
                end
                
                3'b001: begin // Wait for next clock edge
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (!x_reg1) begin
                        next_state = 3'b010;
                        f = 1;
                    end
                end
                
                3'b010: begin // Wait for x = 1
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (x_reg1) begin
                        next_state = 3'b011;
                        f = 0;
                    end else begin
                        next_state = 3'b010;
                    end
                end
                
                3'b011: begin // Wait for x = 0
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (!x_reg1) begin
                        next_state = 3'b100;
                    end else begin
                        next_state = 3'b011;
                    end
                end
                
                3'b100: begin // Check y
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (y_reg2 && y_reg1 && y) begin
                        next_state = 3'b101;
                    end else begin
                        next_state = 3'b100;
                    end
                end
                
                3'b101: begin // Wait for y = 1
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (y_reg1) begin
                        next_state = 3'b110;
                        g = 1;
                    end else begin
                        next_state = 3'b101;
                    end
                end
                
                3'b110: begin // Maintain g = 1
                    if (resetn == 1'b0) begin
                        next_state = 3'b000;
                    end else if (!y_reg2) begin
                        next_state = 3'b111;
                    end else begin
                        next_state = 3'b110;
                    end
                end
                
                3'b111: begin // Reset to state A
                    f = 0;
                    g = 0;
                    next_state = 3'b000;
                end
            endcase
            
            state <= next_state;
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_reg1 <= 0;
            x_reg2 <= 0;
            x_reg3 <= 0;
        end else begin
            x_reg3 <= x_reg2;
            x_reg2 <= x_reg1;
            x_reg1 <= x;
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_reg1 <= 0;
            y_reg2 <= 0;
        end else begin
            y_reg2 <= y_reg1;
            y_reg1 <= y;
        end
    end
endmodule
