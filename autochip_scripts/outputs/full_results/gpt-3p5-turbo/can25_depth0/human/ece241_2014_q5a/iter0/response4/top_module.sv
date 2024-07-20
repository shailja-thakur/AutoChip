module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [1:0] z_reg;
    
    always @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            state <= 2'b00;
            z_reg <= 2'b00;
        end else begin
            state <= next_state;
            z_reg <= z_reg + x;
        end
    end
    
    always @(state, x) begin
        case (state)
            2'b00: begin
                if (areset == 0) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b00;
                end
            end
            2'b01: begin
                next_state = 2'b10;
            end
            2'b10: begin
                next_state = 2'b01;
            end
        endcase
    end
    
    assign z = z_reg[0] ? ~z_reg + 1 : z_reg;
    
endmodule
