module top_module (
	input clk,
	input areset,
	input x,
	output z
);

    reg z_reg;
    reg [2:0] state;
    reg [2:0] next_state;
    wire conversion_done;
    assign conversion_done = (state == 3'b011);
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 3'b000;
        else
            state <= next_state;
    end
    
    always @(state, x) begin
        case (state)
            3'b000: begin
                if (x)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
                z_reg <= x;
            end
            3'b001: begin
                if (x)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
                z_reg <= ~x;
            end
            3'b010: begin
                if (x)
                    next_state = 3'b011;
                else
                    next_state = 3'b010;
                z_reg <= ~x;
            end
            3'b011: begin
                next_state = 3'b011;
                z_reg <= z_reg;
            end
        endcase
    end
    
    assign z = z_reg;
    
endmodule
