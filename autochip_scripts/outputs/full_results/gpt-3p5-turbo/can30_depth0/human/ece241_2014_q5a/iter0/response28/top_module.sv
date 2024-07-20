module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    reg [3:0] state;
    reg [3:0] next_state;
    reg z_reg;
    wire x_reg;
    
    assign x_reg = x;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 4'b0000;
            z_reg <= 1'b0;
        end else begin
            state <= next_state;
            z_reg <= ~x_reg;
        end
    end
    
    always @(state, x_reg) begin
        next_state = state;
        case (state)
            4'b0000: begin
                if (x_reg) begin
                    next_state = 4'b0001;
                end
            end
            4'b0001: begin
                if (x_reg) begin
                    next_state = 4'b0010;
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0010: begin
                if (x_reg) begin
                    next_state = 4'b0011;
                end else begin
                    next_state = 4'b0000;
                end
            end
            4'b0011: begin
                if (x_reg) begin
                    next_state = 4'b0011;
                end else begin
                    next_state = 4'b0000;
                end
            end
        endcase
    end
    
    assign z = z_reg;
    
endmodule
