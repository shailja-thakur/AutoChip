module top_module (
    input wire clk,
    input wire areset,
    input wire x,
    output wire z
);
	
    // Define local parameters
    parameter IDLE_STATE = 2'b00;
    parameter CONVERT_STATE = 2'b01;
    parameter RESET_STATE = 2'b10;
    
    // Define local wire signals
    reg [1:0] state;
    reg [1:0] next_state;
    reg z_reg;
    wire reset_cond;
    
    // Determine reset condition
    assign reset_cond = (areset == 1'b1) ? 1'b0 : 1'b1;
    
    always @(posedge clk or negedge areset) begin
        if (areset == 1'b0)
            state <= RESET_STATE;
        else
            state <= next_state;
    end
    
    always @(state or x or reset_cond) begin
        case (state)
            IDLE_STATE: begin
                if (reset_cond)
                    next_state = RESET_STATE;
                else
                    next_state = CONVERT_STATE;
            end
            
            CONVERT_STATE: begin
                if (reset_cond)
                    next_state = RESET_STATE;
                else if (x == 1'b0)
                    next_state = CONVERT_STATE;
                else
                    next_state = IDLE_STATE;
            end
            
            RESET_STATE: begin
                if (reset_cond)
                    next_state = RESET_STATE;
                else
                    next_state = IDLE_STATE;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset_cond)
            z_reg <= 1'b0;
        else if (state == CONVERT_STATE)
            z_reg <= ~x;
    end
    
    assign z = z_reg;
    
endmodule
