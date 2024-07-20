module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state_reg, state_next;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state_reg <= 4'd0; // Initial state is S0
        else
            state_reg <= state_next;
    end
    
    always @* begin
        state_next = state_reg;
        f = 1'b0;
        g = 1'b0;

        case (state_reg)
            4'd0: begin // S0
                if (x)
                    state_next = 4'd1; // S1
            end
            
            4'd1: begin // S1
                if (x)
                    state_next = 4'd1; // S1
                else
                    state_next = 4'd2; // S10
            end
            
            4'd2: begin // S10
                if (x)
                    state_next = 4'd3; // G1
                else
                    state_next = 4'd0; // S0
            end
            
            4'd3: begin // G1
                if (y)
                    state_next = 4'd4; // P1
                else
                    state_next = 4'd5; // G2
            end
            
            4'd5: begin // G2
                if (y)
                    state_next = 4'd4; // P1
                else
                    state_next = 4'd6; // P0
            end
            
            4'd6: begin // P0
                // P0 remains in the same state
            end
            
            4'd4: begin // P1
                // P1 remains in the same state
            end
            
            default: begin // Error state
                // Handle Error state if necessary
            end
        endcase
        
        if (state_reg == 4'd1 || state_reg == 4'd3 || state_reg == 4'd5)
            g = 1'b1;
        
        if (state_reg == 4'd1)
            f = 1'b1;
    end
    
endmodule
